defmodule SimplechatWeb.RoomLive do
  use SimplechatWeb, :live_view
  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, messages: [], room_id: "default-room", message: "")}
  end

  @impl true
   def handle_event("submit_message", %{"message" => message}, socket) do
    messages = [{socket.assigns.room_id, message} | socket.assigns.messages]
    Logger.info(message: message) 
    {:noreply, assign(socket, messages: messages, message: "")}
  end
end
