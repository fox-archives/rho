# shellcheck shell=bash

rho-fix() {
	local project_slug=$1

	cd "$RHO_PROJECTS_ROOT/$project_slug/repo"

	git -C "$RHO_PROJECTS_ROOT/$project_slug/repo" reset --hard HEAD
	git -C "$RHO_PROJECTS_ROOT/$project_slug/repo" pull origin
}
