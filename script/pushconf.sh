pushd ~/.config/
rm -rf ./nix
cp -r /etc/nixos ./nix
git commit -m "Update nixos configuration: $(date '+%Y-%m-%d %H:%M')"
git push
popd
