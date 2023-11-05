# shellcheck shell=bash

util.show_help() {
	cat <<-"EOF"
	rho [subcommand] [flags]

	Flags:
	  -h, --help: Show help

	Subcommands:
	  shell-init
	  cd
	  fix
	  list
	  new
	EOF
}

util.trim() {
	unset REPLY; REPLY=
	local var=$1

	var="${var#"${var%%[![:space:]]*}"}"
	var="${var%"${var##*[![:space:]]}"}"

	REPLY=$var
}

util.die() {
	printf '%s\n' "Error: $1. Exiting"
	exit 1
}
