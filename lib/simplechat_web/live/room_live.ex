defmodule SimplechatWeb.RoomLive do
  use SimplechatWeb, :live_view
  require Logger

  @impl true
  def mount(%{"id" => room_id}, _session, socket) do
    topic = "room:" <> room_id
    if connected?(socket), do: SimplechatWeb.Endpoint.subscribe(topic)
    {:ok,
      assign(socket,
        room_id: room_id,
        topic: topic,
        messages: ["Welcome to SimpleChat"], 
        temporary_assigns: [messages: [] ])}
  end

  @impl true
   def handle_event("submit_message", %{"message" => message}, socket) do
     Logger.info(message: message) 
     SimplechatWeb.Endpoint.broadcast(socket.assigns.topic, "new-message",message)
    {:noreply, socket}
   end

  @impl true
  def handle_info(%{event: "new-message", payload: message}, socket) do
        {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end
end
