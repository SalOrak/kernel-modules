# Kernel Modules

Developing in the Linux Kernel is intimidating. That is a fact.

This repository contains Kernel Modules exploring how to develop in the Linux Kernel.

## Development Workflow

### Building from source


When building a Linux Kernel module there are 2 possible ways (in this repository): builded using a local kernel repository or using the current kernel of the NixOS built. 

```bash
# Build
./build.sh hello-world local # Builds locally
./build.sh hello-world nixos # Builds using NixOS
```

Given that everything compiled, you should find a `hello.ko` (using the example above) in the `BUILD/hello-world/` directory.

Afterwards, you can use the following commands to list, insert and remove kernel modules:

```bash
# List running modules
lsmod

# Insert a module
insmod hello.ko

# Remove a module
rmmod hello

# Get information about modules
modprobe 

# Get module messages
dmesg
```

### In NixOS (remote)

Building in NixOS using either the current Linux Kernel in the system:

```bash

nix-shell '<nixpkgs>' -A linux.dev

make -C $(nix-build -E '(import <nixpkgs> {}).linux.dev' --no-out-link)/lib/modules/*/build M=$(pwd) modules
```

