#!/bin/bash

# dotfilesディレクトリのパス
dotfiles_dir=~/dotfiles

# 除外するファイルのリスト
exclude_files=("readme.md" ".gitignore")

# dotfilesルート直下のリンクを貼るフォルダのリスト
link_folders=()

# ファイルをリンクする関数
link_file() {
    src=$1 dst=$2

    if [ -e "$dst" -a ! -L "$dst" ]; then
        mv "$dst" "$dst.backup"
    fi

    ln -snf "$src" "$dst"
}

# dotfilesルート直下のテキストファイルのリンクを作成
for file in $(find $dotfiles_dir -maxdepth 1 -type f); do
    filename=$(basename $file)

    if [[ ! " ${exclude_files[@]} " =~ " ${filename} " ]]; then
        link_file "$file" "$HOME/$filename"
    fi
done

# .config内のフォルダとファイルのリンクを作成
for item in $(find $dotfiles_dir/.config -mindepth 1 -maxdepth 1); do
    itemname=$(basename $item)
    link_file "$item" "$HOME/.config/$itemname"
done

# dotfilesルート直下の指定したフォルダのリンクを作成
for folder in "${link_folders[@]}"; do
    link_file "$dotfiles_dir/$folder" "$HOME/$folder"
done
