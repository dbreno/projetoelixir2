defmodule Projeto.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ProjetoWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:projeto, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Projeto.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Projeto.Finch},
      # Start a worker by calling: Projeto.Worker.start_link(arg)
      # {Projeto.Worker, arg},
      # Start to serve requests, typically the last entry
      ProjetoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Projeto.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProjetoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
