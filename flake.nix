# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license
# This is an empty nixCats config.
# you may import this template directly into your nvim folder
# and then add plugins to categories here,
# and call the plugins with their default functions
# within your lua, rather than through the nvim package manager's method.
# Use the help, and the example repository https://github.com/BirdeeHub/nixCats-nvim
# It allows for easy adoption of nix,
# while still providing all the extra nix features immediately.
# Configure in lua, check for a few categories, set a few settings,
# output packages with combinations of those categories and settings.
# All the same options you make here will be automatically exported in a form available
# in home manager and in nixosModules, as well as from other flakes.
# each section is tagged with its relevant help section.
{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    # LAZY WRAPPER ONLY WORKS ON UNSTABLE
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-cats = {
      url = "github:BirdeeHub/nixCats-nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plugins-hlargs = {
      url = "github:m-demare/hlargs.nvim";
      flake = false;
    };
    plugins-nvim-nio = {
      url = "github:nvim-neotest/nvim-nio";
      flake = false;
    };
    plugins-img-clip-nvim = {
      url = "github:HakonHarnes/img-clip.nvim";
      flake = false;
    };
    plugins-gx-nvim = {
      url = "github:chrishrb/gx.nvim";
      flake = false;
    };
    plugins-luarocks-nvim = {
      url = "github:vhyrro/luarocks.nvim";
      flake = false;
    };
    plugins-comment-highlights-nvim = {
      url = "github:leon-richardt/comment-highlights.nvim";
      flake = false;
    };
    plugins-none-ls-extras-nvim = {
      url = "github:nvimtools/none-ls-extras.nvim";
      flake = false;
    };
    plugins-refactoring-nvim = {
      url = "github:ThePrimeagen/refactoring.nvim";
      flake = false;
    };
    plugins-ts-node-action = {
      url = "github:CKolkey/ts-node-action";
      flake = false;
    };
    plugins-luvit-meta = {
      url = "github:Bilal2453/luvit-meta";
      flake = false;
    };
    plugins-ltex-utils = {
      url = "github:jhofscheier/ltex-utils.nvim";
      flake = false;
    };
    plugins-cmp-pandoc-references = {
      # url = "github:jmbuhr/cmp-pandoc-references";
      url = "github:Charging1948/cmp-pandoc-references";
      flake = false;
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };

  # see :help nixCats.flake.outputs
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    nix-cats,
    ...
  } @ inputs: let
    utils = nix-cats.utils;
    luaPath = "${./.}";
    forEachSystem = flake-utils.lib.eachSystem flake-utils.lib.allSystems;
    # the following extra_pkg_config contains any values
    # which you want to pass to the config set of nixpkgs
    # import nixpkgs { config = extra_pkg_config; inherit system; }
    # will not apply to module imports
    # as that will have your system values
    extra_pkg_config = {allowUnfree = true;};
    # sometimes our overlays require a ${system} to access the overlay.
    # management of this variable is one of the harder parts of using flakes.

    # so I have done it here in an interesting way to keep it out of the way.

    # First, we will define just our overlays per system.
    # later we will pass them into the builder, and the resulting pkgs set
    # will get passed to the categoryDefinitions and packageDefinitions
    # which follow this section.

    # this allows you to use pkgs.${system} whenever you want in those sections
    # without fear.
    system_resolved = forEachSystem (system: let
      # see :help nixCats.flake.outputs.overlays
      inherit (utils) standardPluginOverlay;

      # you may define more overlays in the overlays directory, and import them
      # in the default.nix file in that directory.
      # see overlays/default.nix for how to add more overlays in that directory.
      # or see :help nixCats.flake.nixperts.overlays
      dependencyOverlays = [
        (utils.mergeOverlayLists nix-cats.dependencyOverlays.${system}
          ((import ./overlays inputs)
            ++ [
              (utils.standardPluginOverlay inputs)
              # add any flake overlays here.
            ]))
      ];
      # these overlays will be wrapped with ${system}
      # and we will call the same flake-utils function
      # later on to access them.
    in {inherit dependencyOverlays;});
    inherit (system_resolved) dependencyOverlays;
    # see :help nixCats.flake.outputs.categories
    # and
    # :help nixCats.flake.outputs.categoryDefinitions.scheme
    categoryDefinitions = {
      pkgs,
      settings,
      categories,
      name,
      ...
    } @ packageDef: {
      # to define and use a new category, simply add a new list to a set here,
      # and later, you will include categoryname = true; in the set you
      # provide when you build the package using this builder function.
      # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

      # propagatedBuildInputs:
      # this section is for dependencies that should be available
      # at BUILD TIME for plugins. WILL NOT be available to PATH
      # However, they WILL be available to the shell
      # and neovim path when using nix develop
      propagatedBuildInputs = {generalBuildInputs = with pkgs; [];};

      # lspsAndRuntimeDeps:
      # this section is for dependencies that should be available
      # at RUN TIME for plugins. Will be available to PATH within neovim terminal
      # this includes LSPs
      lspsAndRuntimeDeps = {
        general = with pkgs; [
          universal-ctags
          ripgrep
          fd
          fzf
          gcc

          nix-doc
          nil
          nixd
          alejandra
          deadnix
          statix
          manix

          pandoc

          shellharden
          shfmt

          actionlint

          dotenv-linter

          editorconfig-checker

          efm-langserver

          lua-language-server
          stylua
          selene

          gleam

          gopls
          golint
          golines
          gofumpt
          goimports-reviser
          gomodifytags
          impl

          rust-analyzer
          rustfmt

          html-tidy
          prettierd
          vscode-langservers-extracted # HTML/CSS/JSON/ESLint
          nodePackages.typescript-language-server
          nodePackages.svelte-language-server
          nodePackages.vls # Vue
          typescript

          ltex-ls

          pyright
          pylint
          isort
          black
          mypy

          vale

          eslint_d

          typstfmt
          typst-lsp

          mdformat
          markdownlint-cli2
          marksman
          languagetool-rust

          bibtex-tidy
          bibclean

          dart

          zoxide
        ];
      };

      # This is for plugins that will load at startup without using packadd:
      startupPlugins = {
        lazy = with pkgs.vimPlugins; [lazy-nvim];
        debug = with pkgs.vimPlugins; [
          pkgs.neovimPlugins.nvim-nio
          nvim-dap
          nvim-dap-ui
          nvim-dap-virtual-text
          nvim-dap-python
          nvim-dap-go
          telescope-dap-nvim
          neotest
        ];
        general = {
          gitPlugins = with pkgs.neovimPlugins; [hlargs];
          vimPlugins = with pkgs.vimPlugins; [
            lazydev-nvim
            pkgs.neovimPlugins.luvit-meta
            neoconf-nvim
            dressing-nvim
            nvim-cmp
            friendly-snippets
            luasnip
            cmp_luasnip
            cmp-path
            cmp-buffer
            cmp-nvim-lsp
            cmp-nvim-lsp-signature-help
            cmp-calc
            cmp-emoji
            cmp-spell
            cmp-treesitter
            cmp-latex-symbols
            pkgs.neovimPlugins.cmp-pandoc-references
            copilot-lua
            copilot-cmp
            nvim-autopairs
            lspkind-nvim
            plenary-nvim
            nvim-treesitter-textobjects
            nvim-treesitter.withAllGrammars
            nvim-lspconfig
            fidget-nvim
            lualine-nvim
            gitsigns-nvim
            which-key-nvim
            comment-nvim
            conform-nvim
            neogen
            # flash-nvim
            hop-nvim
            nvim-spectre
            nvim-surround
            # tabular
            vim-sleuth
            vim-fugitive
            vim-rhubarb
            vim-repeat
            indent-blankline-nvim
            none-ls-nvim
            pkgs.neovimPlugins.none-ls-extras-nvim
            pkgs.neovimPlugins.refactoring-nvim
            lsp-format-nvim
            vim-tmux-navigator
            zen-mode-nvim

            pkgs.neovimPlugins.ts-node-action

            pkgs.neovimPlugins.gx-nvim
            pkgs.neovimPlugins.img-clip-nvim

            nvim-navic
            nvim-navbuddy

            nvim-colorizer-lua
            nvim-remote-containers

            cloak-nvim
            neocord

            flutter-tools-nvim

            todo-comments-nvim
            pkgs.neovimPlugins.comment-highlights-nvim
          ];
          telescopePlugins = with pkgs.vimPlugins; [
            telescope-nvim
            telescope-manix
            telescope-fzf-native-nvim
            telescope-ui-select-nvim
            telescope-undo-nvim
            telescope-cheat-nvim
            neorg-telescope
            telescope-zoxide
          ];
        };
        scientific = with pkgs.vimPlugins; [
          quarto-nvim
          otter-nvim
          molten-nvim
          vim-slime
          pkgs.neovimPlugins.ltex-utils
        ];
        notes = with pkgs.vimPlugins; [
          pkgs.neovimPlugins.luarocks-nvim
          neorg
        ];
        # You can retrieve information from the
        # packageDefinitions of the package this was packaged with.
        # :help nixCats.flake.outputs.categoryDefinitions.scheme
        themer = with pkgs.vimPlugins; (builtins.getAttr packageDef.categories.colorscheme {
          # Theme switcher without creating a new category
          "onedark" = onedark-nvim;
          "catppuccin-mocha" = catppuccin-nvim;
          "catppuccin" = catppuccin-nvim;
          "tokyonight" = tokyonight-nvim;
          "kanagawa" = kanagawa-nvim;
          "kanagawa-wave" = kanagawa-nvim;
          "kanagawa-dragon" = kanagawa-nvim;
          "kanagawa-lotus" = kanagawa-nvim;
        });
      };

      # not loaded automatically at startup.
      # use with packadd and an autocommand in config to achieve lazy loading
      optionalPlugins = {
        custom = with pkgs.nixCatsBuilds; [];
        gitPlugins = with pkgs.neovimPlugins; [];
        general = with pkgs.vimPlugins; [];
      };

      # shared libraries to be added to LD_LIBRARY_PATH
      # variable available to nvim runtime
      sharedLibraries = {general = with pkgs; [libgit2];};

      # environmentVariables:
      # this section is for environmentVariables that should be available
      # at RUN TIME for plugins. Will be available to path within neovim terminal
      environmentVariables = {
        test = {
          subtest1 = {CATTESTVAR = "It worked!";};
          subtest2 = {CATTESTVAR3 = "It didn't work!";};
        };
      };

      # If you know what these are, you can provide custom ones by category here.
      # If you dont, check this link out:
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
      extraWrapperArgs = {
        test = [''--set CATTESTVAR2 "It worked again!"''];
      };

      # lists of the functions you would have passed to
      # python.withPackages or lua.withPackages
      extraPythonPackages = {test = _: [];};
      extraPython3Packages = {
        scientific = ps:
          with ps; [
            pynvim
            jupyter-client
            ipykernel
            cairosvg
            ipython
            nbformat
            jupytext
          ];
      };
      extraLuaPackages = {
        notes = ps: with ps; [lua-utils-nvim pathlib-nvim];
      };
    };

    # packageDefinitions:

    # Now build a package with specific categories from above
    # All categories you wish to include must be marked true,
    # but false may be omitted.
    # This entire set is also passed to nixCats for querying within the lua.
    # It is directly translated to a Lua table, and a get function is defined.
    # The get function is to prevent errors when querying subcategories.

    # see :help nixCats.flake.outputs.packageDefinitions
    packageDefinitions = {
      # these also recieve our pkgs variable
      nixnvim = {pkgs, ...} @ misc: {
        # see :help nixnvim.flake.outputs.settings
        settings = {
          # will check for config in the store rather than .config
          wrapRc = true;
          configDirName = "nixnvim";
          aliases = ["vi" "vim"];
          # caution: this option must be the same for all packages.
          neovim-unwrapped =
            inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
        };
        # see :help nixCats.flake.outputs.packageDefinitions
        categories = {
          lazy = true;
          generalBuildInputs = true;
          general = true;
          scientific = true;
          notes = true;
          none-ls = true;
          # this does not have an associated category of plugins,
          # but lua can still check for it
          lspDebugMode = false;
          # you could also pass something else:
          themer = true;
          # colorscheme = "catppuccin-mocha";
          colorscheme = "catppuccin";
          theBestCat = "says meow!!";
          theWorstCat = {
            thing'1 = ["MEOW" "HISSS"];
            thing2 = ["I LOVE KEYBOARDS" {thing3 = ["give" "treat"];}];
          };
          # see :help nixCats
        };
      };
    };
    # In this section, the main thing you will need to do is change the default package name
    # to the name of the packageDefinitions entry you wish to use as the default.
    defaultPackageName = "nixnvim";
    # see :help nixCats.flake.outputs.exports
  in
    forEachSystem (system: let
      inherit (utils) baseBuilder;
      customPackager =
        baseBuilder luaPath {
          inherit nixpkgs system dependencyOverlays extra_pkg_config;
        }
        categoryDefinitions;
      nixCatsBuilder = customPackager packageDefinitions;
      # this is just for using utils such as pkgs.mkShell
      # The one used to build neovim is resolved inside the builder
      # and is passed to our categoryDefinitions and packageDefinitions
      pkgs = import nixpkgs {inherit system;};
    in {
      # these outputs will be wrapped with ${system} by flake-utils.lib.eachDefaultSystem

      # this will make a package out of each of the packageDefinitions defined above
      # and set the default package to the one named here.
      packages =
        utils.mkPackages nixCatsBuilder packageDefinitions defaultPackageName;

      # choose your package for devShell
      # and add whatever else you want in it.
      devShells = {
        default = pkgs.mkShell {
          name = defaultPackageName;
          packages = [(nixCatsBuilder defaultPackageName)];
          inputsFrom = [];
          shellHook = "";
        };
      };

      # To choose settings and categories from the flake that calls this flake.
      # and you export overlays so people dont have to redefine stuff.
      inherit customPackager;
    })
    // {
      # these outputs will be NOT wrapped with ${system}

      # this will make an overlay out of each of the packageDefinitions defined above
      # and set the default overlay to the one named here.
      overlays =
        utils.makeOverlays luaPath {
          # we pass in the things to make a pkgs variable to build nvim with later
          inherit nixpkgs dependencyOverlays extra_pkg_config;
          # and also our categoryDefinitions
        }
        categoryDefinitions
        packageDefinitions
        defaultPackageName;

      # we also export a nixos module to allow configuration from configuration.nix
      nixosModules.default = utils.mkNixosModules {
        inherit
          defaultPackageName
          dependencyOverlays
          luaPath
          categoryDefinitions
          packageDefinitions
          nixpkgs
          ;
      };
      # and the same for home manager
      homeModule = utils.mkHomeModules {
        inherit
          defaultPackageName
          dependencyOverlays
          luaPath
          categoryDefinitions
          packageDefinitions
          nixpkgs
          ;
      };
      # now we can export some things that can be imported in other
      # flakes, WITHOUT needing to use a system variable to do it.
      # and update them into the rest of the outputs returned by the
      # eachDefaultSystem function.
      inherit utils categoryDefinitions packageDefinitions dependencyOverlays;
      inherit (utils) templates baseBuilder;
      keepLuaBuilder = utils.baseBuilder luaPath;
    };
}
