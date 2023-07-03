@echo off
:: please, run by admin, and after install `uutils` ln -fs ~\dotfiles\vim\windows\init.lua ~\AppData\Local\nvim\init.lua

goto :main

:link
del %1 2>nul
mklink %1 %2
goto: EOF

:dlink
del %1 2>nul
mklink /d %1 %2
goto: EOF

:main
setlocal enabledelayedexpansion
set DOTFILES=%USERPROFILE%\dotfiles

call :link %USERPROFILE%\Local\AppData\nvim\init.lua %DOTFILES%\vim\windows\init.lua

endlocal
pause
