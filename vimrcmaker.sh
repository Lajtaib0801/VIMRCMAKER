#!/bin/bash

VIMFILELOCATION=/home/$(whoami)/.vimrc
PATHTOSWAPS=/home/$(whoami)/.cache/vim/swap
RCEXISTSVAL=-1




rcfileisexists () {
	if [ -f "$VIMFILELOCATION" ]; then
		RCEXISTSVAL=1
	else
		RCEXISTSVAL=0
	fi
}
rcfileisexists
if [ $RCEXISTSVAL -eq 0 ]; then
	touch "$VIMFILELOCATION"
	echo "call plug#begin()
	Plug 'jacoborus/tender.vim'
	Plug 'rafi/awesome-vim-colorschemes'
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
call plug#end()

	map <C-o> :NERDTreeToggle<CR>
	colorscheme tender
	set nu rnu
	set mouse=a
	set directory=$HOME/.cache/vim/swap//
		
	set encoding=utf-8
	set fileencoding=utf-8
		
	set tabstop=4
	set shiftwidth=4
	set softtabstop=4
	set expandtab" >> "$VIMFILELOCATION"
	echo "Vimfile is created successfully!"
elif [ $RCEXISTSVAL -eq 1 ]; then
	echo "Vimfile is already exist! Do you want to remove(1) or rename(2) it?"
	read -p "Inputs: '1' for remove, '2' for rename: " vimfile

	while [ ! "$vimfile" = "1" ] && [ ! "$vimfile" = "2" ]; do
		echo "Your inputs only can be 1 or 2!"
		read vimfile
	done

	if [ "$vimfile" = "1" ]; then
		rm ${VIMFILELOCATION}
		echo "Vimfile has been removed!"
	elif [ "$vimfile" = "2" ]; then
		echo "Type the new name of the .vimrc!"
		read newname
		mv ${VIMFILELOCATION} ~/${newname}
		echo "The vimfile's name has been changed to '${newname}'!"
	fi
fi

if [ ! -d "$PATHTOSWAPS" ]; then
    echo "'${PATHTOSWAPS}' does not exist! Do you want to create one? [y/N]"
		read create
		if [ -z "$create" ]; then
			create="N"
		fi
		if [ "${create^}" = "Y" ]; then
			mkdir -p $PATHTOSWAPS
		elif [ "${create^}" = "N" ]; then
			exit
		else
			echo "Correct inputs: 'y or Y' =yes, 'n or N' =no!"
		fi
fi
