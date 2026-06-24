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
fvm flutter build web --wasm --base-href /flgame/
# --wasm --base-href /flgame/
cd build/web
rm $zipfile
zip -r $zipfile *
# cp $zipfile ../..
mv $zipfile ../..
cd ../..
echo Current dir:
pwd
ls -l $zipfile $zipfile_old
