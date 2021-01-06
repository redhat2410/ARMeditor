@echo off
SETLOCAL ENABLEDELAYEDEXPANSION


::setup path in folder
::current path of run.bat
set _pathCurrent=%cd%
set _pathLibrary=%_pathCurrent%\lib
set _pathUser=%_pathCurrent%\usr
set _pathSrc=%_pathCurrent%\src
::path main.c 
set _pathSrcMain=%_pathSrc%\main.c
set _pathBuild=%_pathCurrent%\build


set _pathToolChain=C:\Users\Public\Documents\.Toolschain

::link download toolchain and library
set _linkToolsCompiler="https://codeload.github.com/redhat2410/toolchain_arm/zip/master"
set _linkToolsLibrary="https://codeload.github.com/redhat2410/stdperiph_stm32f10x/zip/master"
::check folder lib and tools is exists and download library and tools compiler
::search folder toolchain to download toolchain and library stm32f10x for project
::download toolchain for window and library standart peripheral for stm32f10x
if not exist %_pathToolChain% (
	md %_pathToolChain%
	cd /d%_pathToolChain%
	echo Donwload toolchain for ARM ....
	curl -o lib.zip %_linkToolsLibrary%
	curl -o tools.zip %_linkToolsCompiler%
	echo Download complete.
	echo Unzip packet......
	tar -xf lib.zip
	ren stdperiph_stm32f10x-master lib
	tar -xf tools.zip
	ren toolchain_arm-master tools
	echo Unzip complete.
	del lib.zip
	del tools.zip
	cd /d%_pathCurrent%
	attrib +h %_pathToolChain%
)
::create folder in project folder (src, build, lib, usr,...)
if not exist %_pathLibrary% ( md %_pathLibrary% )
if not exist %_pathSrc% ( md %_pathSrc% )
if not exist %_pathUser% ( md %_pathUser% )
if not exist %_pathBuild% ( md %_pathBuild% )

::setup include path for vscode
set _pathVScode=%_pathCurrent%\.vscode
set _path_c_cpp_properties=%_pathVScode%\c_cpp_properties.json
set _path_launch=%_pathVScode%\launch.json
::path for compiler
set _pathCC_gcc=%_pathToolChain%\tools\bin\arm-none-eabi-gcc
set _pathCC_g++=%_pathToolChain%\tools\bin\arm-none-eabi-g++
set _pathCC_ar=%_pathToolChain%\tools\bin\arm-none-eabi-ar
set _pathCC_objcopy=%_pathToolChain%\tools\bin\arm-none-eabi-objcopy
::path libraries standard for ARM
set _pathLibrariesStandard=%_pathToolChain%\lib

if not exist %_pathVScode% ( 
	md %_pathVScode%
	::hidden folder vscode
	attrib +h %_pathVScode%
)

if exist %_path_c_cpp_properties% ( del %_path_c_cpp_properties% )
::generate file c_cpp_properties.json to configuration include path for c/c++ compiler
::TODO how to generate file c_cpp_properties.json automatic
for /f "tokens=*" %%f in ('dir /b /s /a:d "%_pathLibrariesStandard%"\*') do (
    set _pathLib=%%f
    set content_properties=!content_properties! "!_pathLib!",
)
set content_properties=%content_properties% "%_pathLibrary%",
for /f "tokens=*" %%f in ('dir /b /s /a:d "%_pathLibrary%"\*') do (
    set _pathLib=%%f
    set content_properties=!content_properties! "!_pathLib!",
)
set content_properties=%content_properties% "%_pathSrc%",
for /f "tokens=*" %%f in ('dir /b /s /a:d "%_pathSrc%"\*') do (
    set _pathLib=%%f
    set content_properties=!content_properties! "!_pathLib!",
)
set content_properties=%content_properties% "%_pathUser%",
for /f "tokens=*" %%f in ('dir /b /s /a:d "%_pathUser%"\*') do (
    set _pathLib=%%f
    set content_properties=!content_properties! "!_pathLib!",
)

set content_properties=%content_properties:\=/%
set name_properties="name": "STMicrocontroller IDE",
set include_properties="includePath": [ !content_properties! ""],
set browser_properties="browse": { "limitSymbolsToIncludedHeaders": true, "path": [ !content_properties! "" ]},
set cStandard="cStandard": "c99",
set cppStandard="cppStandard": "c++11",
set compilerPath="compilerPath":"%_pathCC_gcc:\=/%"
set version_properties="version": 1
set config_properties={"configurations": [{%name_properties%%include_properties%%browser_properties%%cStandard%%cppStandard%%compilerPath%}],%version_properties%}

echo %config_properties% >> %_path_c_cpp_properties%
::###################################

::generate file main.c 

if not exist %_pathSrcMain% (
	set contentMain=#include "stm32f10x.h"^& echo.^& echo.int main(void){^& echo.   return 0;^& echo.}
	echo %contentMain%
)