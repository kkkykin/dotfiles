remote ?= vm

.PHONY: set-nvim install-nvim create-remote-dirs

create-remote-dirs:
	ssh -o "RemoteCommand=mkdir -p ~/.config/nvim ~/neovim" $(remote)

set-nvim: create-remote-dirs
	scp -r neovim/_tangle/* $(remote):~/.config/nvim/

install-nvim: set-nvim
	scp -r neovim/_prog/* $(remote):~/neovim/
	ssh -o "RemoteCommand=chmod u+x ~/neovim/nvim-linux-x86_64/bin/*" $(remote)
