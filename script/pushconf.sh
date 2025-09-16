pushd ~/.config/
rm -rf ./nixos
cp -r /etc/nixos ./
git commit -m "Update nixos configuration: $(date '+%Y-%m-%d %H:%M')"
git push
popd
