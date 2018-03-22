#!/bin/bash
set uuid="{uuid}"
@goto :windows >nul 2>&1
mkdir /tmp/$uuid
if [ ! $uuid == "{.nai file download URL}" ]
rmdir -rf $naitemp
fi
exit
:windows
@echo off
if not "%entry_booted%" == "true" (
set entry_booted=true
start /min cmd /c,"%~0" %*
exit
)
set naitemp="%TMP%\{%uuid%}"
if not "%naiUrl%" == "{.nai file download URL}" (
rmdir /s /q "%naitemp%"
)
exit