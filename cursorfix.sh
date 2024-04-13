#!/usr/bin/env bash

CODE_WIN_PATH="$(which code)"
CURSOR_WIN_PATH="$(which cursor)"

# overwrite cursor script with the vscode one
cp "$CODE_WIN_PATH" "$CURSOR_WIN_PATH"

# replace vscode vars and paths with cursor ones
# APP_NAME should not be replaced, since .cursor-server remote-cli still gets downloaded and extracted as "code" executable
#sed -i 's|APP_NAME="code"|APP_NAME="cursor"|' $CURSOR_WIN_PATH
sed -i 's|NAME="Code"|NAME="Cursor"|' $CURSOR_WIN_PATH
sed -i 's|SERVERDATAFOLDER=".vscode-server"|SERVERDATAFOLDER=".cursor-server"|' $CURSOR_WIN_PATH
sed -i -E 's|VSCODE_PATH=".+"|VSCODE_PATH="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")")"|' $CURSOR_WIN_PATH

# fix output from the Cursor in CLI
sed -i -E 's|WSL_EXT_WLOC=(.+)|WSL_EXT_WLOC=$(tail -1 /tmp/remote-wsl-loc.txt)|' $CURSOR_WIN_PATH