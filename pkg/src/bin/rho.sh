# shellcheck shell=bash

rho.main() {
	if [ "$1" = 'shell-init' ]; then
		# TODO: spacing
		cat <<-"EOF"
			_rho_cmd() {
				RHO_CONFIG=${XDG_CONFIG_HOME:-$HOME/.config}/rho
				RHO_DATA=${XDG_DATA_HOME:-$HOME/.local/share}/rho
				RHO_STATE=${XDG_STATE_HOME:-$HOME/.local/state}/rho
				RHO_PROJECTS_ROOT=${RHO_PROJECTS_ROOT:-$RHO_STATE}

				if [ "$1" = 'cd' ]; then
					if [ -z "$2" ]; then
						printf '%s\n' 'Error: rho: Must pass directory' >&2
						return 1
					fi
					cd "$RHO_PROJECTS_ROOT/$2"
				else
					RHO_CONFIG=$RHO_CONFIG \
						RHO_DATA=$RHO_DATA \
						RHO_STATE=$RHO_STATE \
						RHO_PROJECTS_ROOT=$RHO_PROJECTS_ROOT \
						"$HOME/Docs/Programming/repos/Groups/Bash/rho/pkg/bin/rho" "$@"
				fi
			}
			unalias rho 2>/dev/null # TODO
			rho() { _rho_cmd "$@"; }

			_rho() {
				local i=1 cmd=
				local cur="${COMP_WORDS[COMP_CWORD]}"
				COMPREPLY=($(compgen -W "shell-init cd fix list new --help --version" -- "$cur"))
			}
			complete -F _rho rho
		EOF
		return
	fi


	if [ -z "$RHO_CONFIG" ]; then
		util.die "Variable 'RHO_CONFIG' cannot be empty"
	fi

	if [ -z "$RHO_DATA" ]; then
		util.die "Variable 'RHO_DATA' cannot be empty"
	fi

	if [ -z "$RHO_STATE" ]; then
		util.die "Variable 'RHO_STATE' cannot be empty"
	fi

	if [ -z "$RHO_PROJECTS_ROOT" ]; then
		util.die "Variable 'RHO_PROJECTS_ROOT' cannot be empty"
	fi

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
	if ! shift; then
		util.die "Failed to unshift"
	fi

	mkdir -p "$RHO_PROJECTS_ROOT"
	case $action_name in
		fix)
			rho-fix "$@"
			;;
		list)
			rho-list "$@"
			;;
		new)
			rho-new "$@"
			;;
	esac
}
