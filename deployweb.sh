function pause(){
 read -s -n 1 -p "Press any key to continue . . ."
 echo ""
}

zipfile=flgameweb.zip
zipfileold=$zipfile"_old"
echo cp $zipfile $zipfileold
cp $zipfile $zipfileold
ls -l $zipfile $zipfile_old
pause
# flutter clean
# flutter pub get
# fvm flutter build web --no-wasm  --base-href /flgame/
flutter build web --base-href /flgame/
#  --release
# fvm flutter build web --no-wasm --base-href /flgame/
# --wasm --base-href /flgame/
cd build/web
pwd
pause
rm $zipfile
zip -r $zipfile *
# cp $zipfile ../..
mv $zipfile ../..
pause
cd ../..
echo Current dir:
pwd
ls -l $zipfile $zipfile_old
