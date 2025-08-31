exp_args=1

function usage() {
    echo -e "Usage: $0 <name>"
    echo -e "\tWhere <name> is the directory name where kernel module lives"
    echo -e "\tExample: $0 hello-world   <-- Builds the \`hello-world\` kernel module\n"
}

if [[ $# -ne "$exp_args" ]]; then
    echo -e "Expected $exp_args arguments but found $#\n"
    usage
    exit 1
fi

module_name=$1
module_path="$PWD/$module_name"

if [[ ! -d $module_path ]]; then
    echo -e "Kernel module \`$module_path\` not found."
    usage
    exit 1
fi

# Because the module lives outside the kernel tree
# lets help make find the kernle source
make -C ~/personal/linux M=$PWD/$1


exit 0
