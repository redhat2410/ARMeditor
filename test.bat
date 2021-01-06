@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set _pathCurrent=%cd%
set _pathLibrary=%_pathCurrent%\lib
set _pathUser=%_pathCurrent%\usr
set _pathSrc=%_pathCurrent%\src
set _path_c_cpp_properties=%_pathCurrent%\c_cpp_properties.json
set _pathToolChain="C:\Users\Public\Documents\.Toolschain"
set _pathToolsLibraries=%_pathToolChain%\lib
set _pathMain=%_pathCurrent%\main.c

set content=#include "stm32f10x.h"^& echo.^& echo.int main(void){^& echo.   return 0;^& echo.}
set tcontent=%content%
echo %tcontent%>>%_pathMain%