IF EXIST ".\pulsar.exe" (del .\pulsar.exe)
IF EXIST ".\pulsar_min.exe" (del .\pulsar_min.exe)
IF EXIST ".\pulsar_cli.exe" (del .\pulsar_cli.exe)
nimble install --depsOnly -y
nim c -d:release --gc:orc -d:useMalloc pulsar_cli.nim
nim --app:gui c -d:release --gc:orc -d:useMalloc .\pulsar.nim
nim --app:gui c -d:release --gc:orc -d:useMalloc .\pulsar_min.nim
