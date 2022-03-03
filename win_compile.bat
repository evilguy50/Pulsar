nimble install --depsOnly
powershell.exe rm -R pulsar_cli.exe
nim compile pulsar_cli.nim
powershell.exe rm -R pulsar.exe
nim --app:gui c -r -d:release --gc:orc -d:useMalloc .\pulsar.nim
