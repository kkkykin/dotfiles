remote ?= vm

.PHONY: set-nvim \
	install-nvim \
	create-remote-nvim-conf-dirs \
	create-remote-nvim-bin-dirs

create-remote-nvim-conf-dir:
	ssh -o "RemoteCommand=mkdir -p ~/.config/nvim" $(remote)

create-remote-nvim-bin-dir:
	ssh -o "RemoteCommand=mkdir -p ~/.local/bin/nvim" $(remote)

set-nvim: create-remote-nvim-conf-dir
	scp -r neovim/_tangle/* $(remote):~/.config/nvim/

install-nvim: set-nvim create-remote-nvim-bin-dir
	cat neovim/_prog/* | ssh -o "RemoteCommand=tar -C ~/.local/bin/nvim/ -xzvf -" $(remote)
