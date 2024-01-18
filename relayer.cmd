@echo off
title Unix Terminal for Windows
setlocal EnableDelayedExpansion
set /p version=<terminal.version

echo Welcome to UTW %version%
echo.

:loop
set /p "cmd=%cd%> "

if /i "!cmd!"=="exit" (
    goto :eof
)

for /f "tokens=1,* delims= " %%a in ("!cmd!") do (
    set command=%%a
    set args=%%b
)

if /i "!command!"=="ls" (
    call :exec_ls "!args!"
) else if /i "!command!"=="ll" (
    call :exec_ll "!args!"
) else if /i "!command!"=="df" (
    call :exec_df "!args!"
) else if /i "!command!"=="rm" (
    call :exec_rm "!args!"
) else if /i "!command!"=="touch" (
    call :exec_touch "!args!"
) else if /i "!command!"=="cp" (
    call :exec_cp "!args!"
) else if /i "!command!"=="mv" (
    call :exec_mv "!args!"
) else if /i "!command!"=="mkdir" (
    call :exec_mkdir "!args!"
) else if /i "!command!"=="rmdir" (
    call :exec_rmdir "!args!"
) else if /i "!command!"=="grep" (
    call :exec_grep "!args!"
) else if /i "!command!"=="kill" (
    call :exec_kill "!args!"
) else if /i "!command!"=="cd" (
    call :exec_cd "!args!"
) else if /i "!command!"=="bash" (
    call :exec_bash "!args!"
) else (
    echo Unknown command: !command!
)

goto loop

:exec_ls
dir %1
goto :eof

:exec_ll
dir %1
goto :eof

:exec_df
wmic logicaldisk get size,freespace,caption
goto :eof

:exec_rm
set arg=%1
if "!arg:~0,2!"=="-r" (
    rmdir /s /q %2
) else (
    del /f /q %1
)
goto :eof

:exec_touch
type nul > %1
goto :eof

:exec_cp
copy %1 %2
goto :eof

:exec_mv
move %1 %2
goto :eof

:exec_mkdir
mkdir %1
goto :eof

:exec_rmdir
rmdir /s /q %1
goto :eof

:exec_grep
findstr %1 %2
goto :eof

:exec_kill
taskkill /PID %1
goto :eof

:exec_cd
cd %1
goto :eof

:exec_bash
%1
goto :eof
