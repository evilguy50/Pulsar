nimble install --depsOnly
powershell.exe rm -R pulsar_cli.exe
nim compile pulsar_cli.nim
powershell.exe rm -R pulsar.exe
powershell.exe rm -R pulsar_min.exe
nim --app:gui c -d:release --gc:orc -d:useMalloc .\pulsar.nim
nim --app:gui c -d:release .\pulsar_min.nim