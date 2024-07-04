@echo off
setlocal enabledelayedexpansion
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

call :link %USERPROFILE%\AppData\Local\nvim\init.lua %DOTFILES%\vim\init.lua
call :dlink %USERPROFILE%\AppData\Local\nvim\lua %DOTFILES%\vim\lua

endlocal
pause
