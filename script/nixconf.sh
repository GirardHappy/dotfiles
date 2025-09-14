#non funziona
set -e
pushd "/etc/nixos"
code --wait ./ --user-data-dir="~/.vscode-root"
git diff -U0 *.nix
echo "NixOS Rebuilding..."

# Rebuild NixOS as root
sudo nixos-rebuild switch &>nixos-switch.log || (
    cat nixos-switch.log | grep --color error
    false
)
gen=$(nixos-rebuild list-generations | grep current)
sudo git commit origin main
popd