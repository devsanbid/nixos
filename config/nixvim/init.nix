{lib,pkgs,...}:
{
	programs.nixvim = {
		enable = true;
		clipboard.providers.wl-copy.enable = true;

		plugins = {
			commentary.enable = true;
			flash.enable = true;
			lazy.enable = true;
			luasnip.enable = true;
			tmux-navigator.enable = true;
			transparent.enable = true;
			snacks.enable = true;
			nvim-autopairs.enable = true;
			treesitter.enable = true;
			    blink-ripgrep.enable = true;
			        blink-cmp-dictionary.enable = true;
				blink-cmp = {
				enable = true;
				settings = {
        keymap = {
          preset = "super-tab";
        };
        signature = {
          enabled = true;
        };
				};
		};
		};

		## lsp
		plugins.lsp = {
		enable = true;
		 servers = {
        nixd = {
          enable = true;
          settings =
            let
              flake = ''(builtins.getFlake "github:elythh/flake)""'';
              flakeNixvim = ''(builtins.getFlake "github:elythh/nixvim)""'';
            in
            {
              nixpkgs = {
                expr = "import ${flake}.inputs.nixpkgs { }";
              };
              formatting = {
                command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
              };
              options = {
                nixos.expr = ''${flake}.nixosConfigurations.grovetender.options'';
                nixvim.expr = ''${flakeNixvim}.packages.${pkgs.system}.default.options'';
              };
            };
        };
		};


	};
};
}
