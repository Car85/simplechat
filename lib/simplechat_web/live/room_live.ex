defmodule SimplechatWeb.RoomLive do
  use SimplechatWeb, :live_view
  require Logger

  @impl true
  def mount(%{"id" => room_id}, _session, socket) do
    topic = "room:" <> room_id
    username = MnemonicSlugs.generate_slug(2)
    if connected?(socket) do
      SimplechatWeb.Endpoint.subscribe(topic)
      SimplechatWeb.Presence.track(self(), topic, username, %{})
    end  
     {:ok,
      assign(socket,
        room_id: room_id,
        topic: topic,
        new_message: "",
        username: username,
        messages: [%{uuid: UUID.uuid4(), content: "Welcome to SimpleChat #{username}", username: "system"}], 
        temporary_assigns: [messages: [] ])}
  end

  @impl true
   def handle_event("submit_message", %{"message" => message}, socket) do
     message = %{uuid: UUID.uuid4(), content: message, username: socket.assigns.username}
     SimplechatWeb.Endpoint.broadcast(socket.assigns.topic, "new-message",message)
    {:noreply, assign(socket, new_message: "" )}
   end

  @impl true
   def handle_event("form_update", %{"message" => message}, socket) do
     {:noreply, assign(socket, new_message: message)}
   end

  @impl true
  def handle_info(%{event: "new-message", payload: message}, socket) do
        {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end

  @impl true
  def handle_info(%{event: "presence_diff", payload: %{joins: joins, leaves: leaves}}, socket) do
    join_messages = 
      joins
      |> Map.keys()
      |> Enum.map(fn username -> %{uuid: UUID.uuid4(), content: "#{username} joined", username: "system"} end)

     leave_messages = leaves
     |> Map.keys()
     |> Enum.map(fn username -> %{uuid: UUID.uuid4(), content: "#{username} left", username: "system"} end)
    {:noreply, assign(socket, messages: join_messages ++ leave_messages)}
  end
end
