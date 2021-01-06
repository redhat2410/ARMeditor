
_pathCurrent=$(pwd)
_pathLibrary=$_pathCurrent/lib
_pathTools=$_pathCurrent/tools
_pathUser=$_pathCurrent/usr
_pathSource=$_pathCurrent/src
_pathBuild=$_pathCurrent/build
_pathRootTools="/home/.toolchain/"

#link download toolchain va library standard peripheral
_linkToolchain="https://codeload.github.com/redhat2410/toolchain_arm_linux/zip/master"
_linkLibraryStandard="https://codeload.github.com/redhat2410/stdperiph_stm32f10x/zip/master"
#kiem tra thu muc toolchain da ton tai chua?
#neu chua se download toolchain for arm and library
if [ ! -e $_pathRootTools ]
then
	#create folder toolchain
	mkdir $_pathRootTools
	#download toolchain and library
	echo "Download toolchain for ARM ...."
	wget $_linkLibraryStandard -O $_pathRootTools/lib.zip
	wget $_linkToolchain -O $_pathRootTools/tools.zip
	echo "Unzip packet....."
	unzip -q $_pathRootTools/lib.zip
	unzip -q $_pathRootTools/tools.zip
	mv stdperiph_stm32f10x-master/ lib/
	mv toolchain_arm_linux-master/ tools/
	echo "Unzip complete."
	rm lib.zip
	rm tools.zip
fi

####### perform create folder for project #######
if [ ! -e $_pathLibrary ]
then
	#creat folder lib in project folder
	mkdir $_pathLibrary
fi

if [ ! -e $_pathSource ]
then
	#creat folder src in project folder
	mkdir $_pathSource
fi

if [ ! -e $_pathUser ]
then
	#create folder usr in project folder
	mkdir $_pathUser
fi

if [ ! -e $_pathBuild ]
then
	#create folder build in project folder
	mkdir $_pathBuild
fi

#################################################

