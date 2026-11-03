# fvm flutter build apk --release --tree-shake-icons --target-platform=android-arm,android-arm64
fvm flutter build apk --split-per-abi
# fvm flutter build apk --obfuscate --release --split-per-abi --tree-shake-icons --target-platform=android-arm,android-arm64
# --no-tree-shake-icons
