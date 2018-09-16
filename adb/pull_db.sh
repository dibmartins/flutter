#!/bin/bash
#~/Android/Sdk/platform-tools/adb -s 0016256682 pull data/data/com.example.app/databases/forca_vendas.db
#~/Android/Sdk/platform-tools/adb exec-out run-as com.example.app pull data/data/com.example.app/databases/forca_vendas.db
~/Android/Sdk/platform-tools/adb -d shell "run-as com.example.app cat /data/data/com.example.app/databases/app.db" > ./build/app.db