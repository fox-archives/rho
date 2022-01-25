# shellcheck shell=bash

rho-fix() {
	local project_slug=$1

	cd "$RHO_PROJECTS_ROOT/$project_slug"
	ln -fs "$PWD/Taskfile.sh" "$PWD/repo/Taskfile.sh"
}
