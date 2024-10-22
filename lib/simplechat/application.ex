defmodule Simplechat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SimplechatWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:simplechat, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Simplechat.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Simplechat.Finch},
      # Start a worker by calling: Simplechat.Worker.start_link(arg)
      # {Simplechat.Worker, arg},
      # Start to serve requests, typically the last entry
      SimplechatWeb.Endpoint,
      SimplechatWeb.Presence
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Simplechat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SimplechatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
