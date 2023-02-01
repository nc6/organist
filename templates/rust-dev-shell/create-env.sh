#!/bin/sh


for devenv in $(awk '/= BashShell/ { print $1 }' builders.ncl)
do
  ENV_NAME="dev-$(echo $devenv | tr [A-Z] [a-z] | sed 's/shell$//')"
  DEST="../$ENV_NAME"
  echo $ENV_NAME

  rm -fr "$DEST"
  mkdir -p "$DEST"
  cp builders.ncl contracts.ncl flake.*  naked-stdenv.ncl naked-stdenv.sh "$DEST"

  cat <<EOF > "${DEST}/dev-shell.ncl"
let builders = import "builders.ncl" in

{
  output = {
    name = "nickel-shell",
  }
} & builders.$devenv
EOF
 
done