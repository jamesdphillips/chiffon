# 🍰

## Goals

* Open-source SSO & token based authentication solution
* Simple; core should never be more complex than a Plug
* Secure
* Performant under high request volume
* Extensible; simple API to add new Auth/Identity providers
* Configurable from CLI _and_ optional administration web app
* No requirement on JVM (CAS)
* Simple enought to drop into any existing Erlang/Elixir project
* Configurable and powerful enough to be deployed on it's own
* Client implementations in major languages
  * Javascript
  * Swift
  * Java
  * Go?

## Roadmap

### v0.1

* [ ] Core Plug w/ authentication API
* [ ] Simple provider API
  * [ ] Google
  * [ ] Facebook
  * [ ] Passwordless
  * [ ] Password (two-factor?)
* [ ] Ecto migration to create tables w/ Mix task
* [ ] Mix tasks to configure providers
* [ ] Server for running as standalone application
* [ ] Exponential backoff
* [ ] Session support
* [ ] Security(?)
* [ ] Better name???

### And beyond..

* [ ] OAuth Provider
  * [ ] Scopes
  * [ ] OpenID Connect(?)
* [ ] Administration panel
  * [ ] GrahpQL API
  * [ ] Lokka, Redux, React FE 
  * [ ] Provider API for configuration components
* [ ] Deployment recipes
  * [ ] Chef
  * [ ] Docker image?
* [ ] ...?

## License

Dunno.
