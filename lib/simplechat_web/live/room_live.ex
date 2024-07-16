defmodule SimplechatWeb.RoomLive do
  use SimplechatWeb, :live_view
  require Logger

  @impl true
  def mount(%{"id" => room_id}, _session, socket) do
    topic = "room:" <> room_id
    SimplechatWeb.Endpoint.subscribe(topic)
    {:ok, assign(socket,  room_id: room_id,  topic: topic, messages: ["Welcome to SimpleChat"])}
  end

  @impl true
   def handle_event("submit_message", %{"message" => message}, socket) do
     topic = socket.assigns.topic
     formatted_message = "#{topic}: #{message}"
     messages = ["#{socket.assigns.room_id}: #{message}" | socket.assigns.messages]
     Logger.info(message: message) 
     SimplechatWeb.Endpoint.broadcast(socket.assigns.topic, "new-message",formatted_message)
    {:noreply, socket}
   end

  @impl true
  def handle_info(%{event: "new-message", payload: message}, socket) do
    topic = socket.assigns.topic
    formatted_message = "#{topic}: #{message}"
    messages = [formatted_message | socket.assigns.messages]
    Logger.info(payload: message)
    {:noreply, assign(socket, messages: socket.assigns.message ++ [message])}
  end
end
