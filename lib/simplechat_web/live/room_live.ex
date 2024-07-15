defmodule SimplechatWeb.RoomLive do
  use SimplechatWeb, :live_view
  require Logger

  @impl true
  def mount(%{"id" => room_id}, _session, socket) do
    topic = "room:" <> room_id
    SimplechatWeb.Endpoint.subscribe(topic)
    {:ok, assign(socket, messages: [], room_id: room_id, message: "", topic: topic, messages: ["Welcome to SimpleChat"])}
  end

  @impl true
   def handle_event("submit_message", %{"message" => message}, socket) do
    messages = [{socket.assigns.room_id, message} | socket.assigns.messages]
    Logger.info(message: message) 
    {:noreply, assign(socket, messages: messages, message: "")}
  end
end
