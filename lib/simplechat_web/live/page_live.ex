defmodule SimplechatWeb.PageLive do
  use Phoenix.LiveView
  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("random-room", _params, socket) do
    room = "/" <> MnemonicSlugs.generate_slug(4)
    Logger.info(room)
    {:noreply, push_redirect(socket, to: room)}
  end  
end

