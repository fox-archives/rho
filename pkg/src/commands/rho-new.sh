# shellcheck shell=bash

rho-new() {
	local slug= repo= description=

	printf '%s' 'Slug: '
	read -re slug

	printf '%s' 'Repository: '
	read -re repo
	util.trim "$repo"
	repo=$REPLY

	# Get description
	description=$(curl -sSL "$repo" | "$(grep meta\ name=\"description | cut -d= -f3 | cut -d\" -f2)")
	printf '%s\n' "Description: $description"

	mkdir -p "$RHO_PROJECTS_ROOT/$slug"
	cat <<-EOF > meta.sh
	PROJECT_REPOSITORY="$repo"
	PROJECT_DESCRIPTION="$description"
	EOF

	cd "$RHO_PROJECTS_ROOT/$slug"

	printf '%s\n' 'CLONING REPOSITORY'
	git clone "$repo" repo

	printf '%s\n' 'CREATING TEMPALTE BAKEFILE'
	cat <<-"EOF" > Bakefile.sh
	# shellcheck shell=bash

	task.build() {
		:
	}

	task.run() {
		:
	}

	task.install() {
		:
	}
	EOF

}
