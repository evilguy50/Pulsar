nimble install --depsOnly
nim c pulsar_cli.nim
nim --app:gui c -d:release --gc:orc -d:useMalloc .\pulsar.nim
nim c --app:lib --out:./User_templates/python/pulsar_py.pyd --threads:on --tlsEmulation:off --passL:-static pulsar_py.nim
nim --app:gui c -d:release .\pulsar_min.nim
