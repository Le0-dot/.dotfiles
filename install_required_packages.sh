sudo pacman -S $(awk '{print $1}' required_packages.txt)
