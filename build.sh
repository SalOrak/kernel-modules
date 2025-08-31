exp_args=2

function usage() {
    echo -e "Usage: $0 <name> <system>"
    echo -e "\tWhere <name> is the directory name where kernel module lives"
    echo -e "\tWhere <system> is either \`local\` or \`nixos\` "
    echo -e "\t\t\`local\`: Builds it against local kernel repository."
    echo -e "\t\t\`nixos\`: Builds inside NixOS derivation and copies the result."
    echo -e "\tExample: $0 hello-world nixos  <-- Builds the \`hello-world\` kernel module builded in nixos\n"
}

if [[ $# -ne "$exp_args" ]]; then
    echo -e "Expected $exp_args arguments but found $#\n"
    usage
    exit 1
fi

module_name=$1
system=$2
module_path="$PWD/$module_name"

build_folder="BUILD"

if [[ ! -d $module_path ]]; then
    echo -e "Kernel module \`$module_path\` not found."
    usage
    exit 1
fi

# Let's create the build folder

case "$system" in
    nixos | Nixos | NixOS | nixOs)
        mkdir -p "$build_folder/$module_name/"
        echo "[BUILD]: Building using Nix for module: $module_name..."
        cp $(nix-build $module_name --no-build-output --no-out-link)/modules/*.ko "$build_folder/$module_name/"
        ;;
    local | Local | locally)
        mkdir -p "$build_folder/$module_name/"
        echo "[BUILD]: Locally building module $module_name..."
        make -C ~/personal/linux M="$PWD/$module_name" 
        mv $PWD/$module_name/*.ko "$build_folder/$module_name/"
        make -C ~/personal/linux M="$PWD/$module_name" clean --quiet
        ;;
    *)
        echo -e "<system> must be either \`nixos\` or \`local\`\n\tFound $system\n"
        usage
        exit 1
        ;;
esac



exit 0
