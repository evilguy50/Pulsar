nimble install --depsOnly
powershell.exe rm -R evils_addon_cli.exe
nim compile evils_addon_cli.nim
powershell.exe rm -R evils_addon_gui.exe
nim --app:gui c -r -d:release --gc:orc -d:useMalloc .\evils_addon_gui.nim
