#!/bin/bash
set uuid="{uuid}"
set naiUrl="{.nai file download URL}"
set nodeVer="8.10.0"
@goto :windows >nul 2>&1
set naitemp="/tmp/$uuid"
mkdir $naitemp
if [ ! -e /var/.nai ]; then
if [ ! $uuid == "{.nai file download URL}"]; then
set naiVer="b1.0"
echo true > $naitemp/.nai
wget https://nodejs.org/dist/v$nodever/node-v$nodever-linux-x86.tar.xz
cp ./node-v$nodever-linux-x86.tar.xz $naitemp/node-v$nodever-linux-x86.tar.xz
tar -Jxvf $naitemp/node-v$nodever-linux-x86.tar.xz
$naitemp/node-v$nodever-linux-x86/bin/npm -g install electron
$naitemp/node-v$nodever-linux-x86/node $naitemp/nai/! $naitemp/node-v$nodever-linux-x86 `pwd` $naiVer $*
rmdir -rf $naitemp
fi
fi
exit
:windows
@echo off
if not "%entry_booted%"=="true" (
set entry_booted=true
start /min cmd /c,"%~0" %*
exit
)
set naitemp="%TMP%\{%uuid%}"
if not exist "%naitemp%\.nai" (
if not "%naiUrl%"=="{.nai file download URL}" (
set naiVer="b1.0"
mkdir %naitemp%
echo true > "%naitemp%\.nai"
attrib "%naitemp%\.nai" +H
echo dim objShell,objWshShell,objFolder,ZipFile,i > "%naitemp%\unzip.vbs"
echo Set objShell=CreateObject("shell.application") >> "%naitemp%\unzip.vbs"
echo Set objWshShell=WScript.CreateObject("WScript.Shell") >> "%naitemp%\unzip.vbs"
echo Set ZipFile=objShell.NameSpace (WScript.Arguments(0)).items >> "%naitemp%\unzip.vbs"
echo if WScript.Arguments.Count=2 then >> "%naitemp%\unzip.vbs"
echo Set objFolder=objShell.NameSpace (WScript.Arguments(1)) >> "%naitemp%\unzip.vbs"
echo else >> %naitemp%\unzip.vbs
echo Set objFolder=objShell.NameSpace (objWshShell.CurrentDirectory) >> "%naitemp%\unzip.vbs"
echo end if >> "%naitemp%\unzip.vbs"
echo objFolder.CopyHere ZipFile, &H14 >> "%naitemp%\unzip.vbs"
bitsadmin /TRANSFER "http://nodejs.org/v%nodeVer%/node-v%nodeVer%-win-x86.zip" "%naitemp%\node.zip"
bitsadmin /TRANSFER "%naiUrl%" "%naitemp%\nai.zip"
CScript "%naitemp%\unzip" "%naitemp%\node.zip" "%naitemp%\"
CScript "%naitemp%\unzip" "%naitemp%\nai.zip" "%naitemp%\nai\"
"%naitemp%\node-v%nodeVer%-win-x86\npm" -g install electron
"%naitemp%\node-v%nodeVer%-win-x86\node" "%naitemp%\nai\!" "%naitemp%\node-v%nodeVer%-win-x86" "%CD%" "%naiVer%" %*
rmdir /s /q "%naitemp%"
)
)
exit