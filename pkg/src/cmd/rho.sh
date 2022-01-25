# shellcheck shell=bash

rho.main() {
	# TODO
	set -eo pipefail

	RHO_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/woof"
	RHO_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/woof"
	RHO_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}/woof"

	: RHO_PROJECTS_ROOT:="$RHO_STATE_HOME"

	local subcmds=()
	for arg; do case $arg in
		--help|-h)
			util.show_help
			;;
		-*)
			util.die "Flag '$arg' not recognized"
			;;
		*)
			subcmds+=("$arg")
			;;
	esac done; unset arg

	local action_name="${subcmds[0]}"
	if [ -z "$action_name" ]; then
		util.show_help
		util.die "No action was given"
	fi

	case $action_name in
		new)
			rho-new
			;;
		fix)
			rho-fix
			;;
	esac
}
