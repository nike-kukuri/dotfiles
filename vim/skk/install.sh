#!/bin/bash
nvim_path=~/.config/skk

if [ ! -e ~/.config/skk ]; then
  mkdir -p $nvim_path
fi

if [[ ! -e $nvim_path/azik_kanatable.json ]]; then
  ln -s $PWD/azik_kanatable.json $nvim_path/azik_kanatable.json
fi

if [[ ! -e $nvim_path/SKK-JISYO.L ]]; then
  ln -s $PWD/SKK-JISYO.L $nvim_path/SKK-JISYO.L
fi
