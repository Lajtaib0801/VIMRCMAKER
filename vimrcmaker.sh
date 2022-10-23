#!/bin/bash

vimfilelocation="/home/$(whoami)/.vimrc"


rcfileisexists() {
	isexists=-1
	if [ -f "$vimfilelocation" ]; then
		isexists=1
	else
		isexists=0
	fi
	return "$isexists"
}

if [ "$rcfileisexists" = "0" ]; then
	touch "$vimfilelocation"
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
		set expandtab" >> "$vimfilelocation"
		echo "Vimfile is created successfully!"
else
	echo "Vimfile is already exist! Do you want to remove(1) or rename(2) it?"
	read -p "Inputs: '1' for remove, '2' for rename: " vimfile

	while [ ! "$vimfile" = "1" ] && [ ! "$vimfile" = "2" ]; do
		echo "Your inputs only can be 1 or 2!"
		read vimfile
	done

	if [ "$vimfile" = "1" ]; then
		rm ${vimfilelocation}
		echo "Vimfile has been removed!"
	elif [ "$vimfile" = "2" ]; then
		echo "Type the new name of the .vimrc!"
		read newname
		mv ${vimfilelocation} ~/${newname}
		echo "The vimfile's name has been changed to '${newname}'!"
	fi
fi












