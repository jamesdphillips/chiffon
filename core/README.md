# Cake

Simple SSO & Token Base Authentication Provider

## Installation

  1. Add cake to your list of dependencies in `mix.exs`:

        def deps do
          [{:cake, "~> 0.0.1"}]
        end

  1. Ensure cake is started before your application:

        def application do
          [applications: [:cake]]
        end
        
  1. Fetch dependencies:
  
        mix deps.get
        
  1. Cake uses Ecto to store identities and configuration; update `config.exs``:
  
        ```elixir
        config :cake, %{
          database: # ...
        }
        ```
  
  1. Create tables & insert initial dataset.
        
        mix cake.migrate

  1. Add the plug to your Router:
  
        ```elixir
        # Handle authentication requests
        plug Cake.Plug
        
        # Consume requests where authentication token / session is present
        plug Cake.Consume
        ```
        
## TODO

* [ ] 
* [ ] No problems, it's a piece of cake ...
  
## Development

### Tests

    mix test # or...
    mix test.watch # for continuous
    
### Lint

    mix dogma
