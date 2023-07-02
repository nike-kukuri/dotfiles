#!/bin/bash

if [[ ! -e $HOME/.zshrc ]]; then
    ln -s $PWD/zshrc $HOME/.zshrc
fi

if [[ ! -e $HOME/.zprofile ]]; then
    ln -s $PWD/zprofile $HOME/.zprofile
fi

if [[ ! -e $HOME/.p10k.zsh ]]; then
    ln -s $PWD/p10k.zsh $HOME/.p10k.zsh
fi
