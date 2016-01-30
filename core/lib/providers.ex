defmodule Cake.Providers do
  @moduledoc """
  Authorization Providers
  """

  defmodule PreloadProviders do
    @moduledoc false

    @doc false
    defmacro __before_compile__(_env) do
      load_providers!

      quote do
        defp preloaded_plugs, do: unquote(all_loaded_plugs)
      end
    end

    @file_pattern Regex.re_pattern(~r/Cake\.Providers\..*\.beam$/)
    @plug_pattern Regex.re_pattern(~r/Cake\.Providers\.\w*\.Plug$/)

    # TODO:
    #   `all_plugs` is pretty much taken verbatim from Mix.Task maybe worth
    #   extracting into more general module / package.

    defp all_loaded_plugs do
      Enum.reduce :code.all_loaded, [], fn({ module, _ }, acc) ->
        module_str = :erlang.atom_to_list(module)
        if :re.run(module_str, @plug_pattern, [capture: :none]) == :match do
          if is_plug?(module), do: [module|acc], else: acc
        else
          acc
        end
      end
    end

    defp load_providers! do
      Enum.reduce(:code.get_path, [], fn(path, matches) ->
        { :ok, files } = :erl_prim_loader.list_dir(path |> to_char_list)
        Enum.reduce(files, matches, &match_providers/2)
      end)
    end

    defp match_providers(filename, modules) do
      if :re.run(filename, @file_pattern, [capture: :none]) == :match do
        mod = Path.rootname(filename, '.beam') |> String.to_atom
        if Code.ensure_loaded?(mod), do: [mod | modules], else: modules
      else
        modules
      end
    end

    defp is_plug?(module) do
      function_exported?(module, :call, 2)
    end
  end

  @before_compile PreloadProviders

  @doc "Retrieve all provider modules"
  def all_plugs, do: preloaded_plugs()
end
