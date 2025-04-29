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
	scp -r neovim/_prog/* $(remote):~/.local/bin/nvim/
	ssh -o "RemoteCommand=chmod u+x ~/.local/bin/nvim/nvim-linux-x86_64/bin/*" $(remote)

download-nvim:
	curl -Lo ./neovim/_prog/nvim-linux-x86_64.tar.gz \
      https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
