defmodule SimplechatWeb.PageLive do
  use Phoenix.LiveView

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("random-room", _params, socket) do
    {:noreply, socket}
  end  
end

