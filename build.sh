#!/bin/bash
#===============================================================================
#
#          FILE:  build.sh
# 
#         USAGE:  ./build.sh 
# 
#   DESCRIPTION:  Build script to openfire plugin user-status
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  Openfire source
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  NilsonAguiar (), nilson.aguiar1@gmail.com
#       COMPANY:  PolibrásNet
#       VERSION:  1.0
#       CREATED:  23-01-2014 09:42:04 BRT
#      REVISION:  ---
#===============================================================================


echo ""
echo " *******************************************"
echo "  Este script deverá ser rodado da raiz do "
echo "  repositório apenas deseja continuar(s/n)?"
echo "  Pasta atual: "`pwd`
echo " *******************************************"
echo ""

read ANSWER

if [ ! $ANSWER == "S" -a ! $ANSWER == "s" ]; then 
    exit
fi

USER_STATUS_PATH=`pwd`
OPENFIRE_PATH=$USER_STATUS_PATH"/../openfire"

US_PRMRY_NAME="userStatus"
US_FINAL_NAME="user-status"

#===============================================================================
#Plugin Source Folders
OF_SRC_PATH=$OPENFIRE_PATH"/src"
OF_PLUGINS_PATH=$OF_SRC_PATH"/plugins"
OF_US_PLUGIN_PATH=$OF_PLUGINS_PATH"/"$US_PRMRY_NAME
OF_PLUGINS_BKP_PATH=$USER_STATUS_PATH"/../bkp"

US_SRC_PATH=$USER_STATUS_PATH"/src/main"
US_SRC_PLGN=$OF_US_PLUGIN_PATH"/src"

US_SRC_OF_PATH=$US_SRC_PATH"/openfire"
US_SRC_OF_PLGN=$OF_US_PLUGIN_PATH

US_SRC_JAVA_PATH=$US_SRC_PATH"/java"
US_SRC_JAVA_PLGN=$US_SRC_PLGN"/java"

US_SRC_DB_PATH=$US_SRC_PATH"/database"
US_SRC_DB_PLGN=$US_SRC_PLGN"/database"

US_SRC_WEB_PATH=$US_SRC_PATH"/webapp"
US_SRC_WEB_PLGN=$US_SRC_PLGN"/web"

US_SRC_I18N_PATH=$US_SRC_PATH"/i18n"
US_SRC_I18N_PLGN=$US_SRC_PLGN"/i18n"

US_SRC_LIBS_PATH=$USER_STATUS_PATH"/lib"
US_SRC_LIBS_PLGN=$OF_US_PLUGIN_PATH"/lib"
#===============================================================================

#===============================================================================
#Plugin build Folders

OF_BUILD=$OPENFIRE_PATH"/target"
OF_WORK=$OPENFIRE_PATH"/work"

OF_BUILD_CMD="ant plugins"
OF_BUILD_PATH=$OPENFIRE_PATH"/build"
OF_TARGT_PATH=$OPENFIRE_PATH"/target/openfire/plugins"

US_BIN_PATH=$OPENFIRE_PATH"/work/plugins-dev/"$US_PRMRY_NAME"/target"

US_PLGN_PATH=$OF_TARGT_PATH/$US_FINAL_NAME

US_CLASS_PATH=$US_BIN_PATH"/classes"
US_CLASS_PLGN=$US_PLGN_PATH"/classes"

US_WEB_PATH=$US_PLGN_PATH"/web"

US_WEB_CLASS_PATH=$US_BIN_PATH"/jspc/classes"
US_WEB_JAVA_PATH=$US_BIN_PATH"/jspc/java"
#US_WEB_CLASS_PATH=$US_BIN_PATH"/jspc/classes/org/jivesoftware/openfire/plugin/userStatus"
#US_WEB_JAVA_PATH=$US_BIN_PATH"/jspc/java/org/jivesoftware/openfire/plugin/userStatus"
US_WEB_CLASS_PLUGIN=$US_CLASS_PLGN"/com/reucon/openfire/plugins/jsp"

US_LIB_TEMP1="plugin-userStatus-jspc.jar.pack"
US_LIB_TEMP2="plugin-userStatus.jar.pack"



if [ ! -d $OPENFIRE_PATH ]; then
    echo ""
    echo " *******************************************"
    echo "  Configure o path correto para o openfire "
    echo "  crie o link para a pasta openfire ou mova"
    echo "  a mesma para a pasta acima desta."
    echo " *******************************************"
    echo ""
    exit
fi

if [ ! -d $OF_PLUGINS_BKP_PATH ] ; then
    mkdir $OF_PLUGINS_BKP_PATH
else
    rm -rf $OF_PLUGINS_BKP_PATH
    mkdir $OF_PLUGINS_BKP_PATH
fi

echo " *******************************************"
echo "  Iniciando processo de compilação"
echo " *******************************************"

echo ""
echo "  Efetuando backup dos plugins do OpenFire"
mv $OF_PLUGINS_PATH/* $OF_PLUGINS_BKP_PATH


mkdir $OF_PLUGINS_PATH
mkdir $OF_US_PLUGIN_PATH
mkdir $US_SRC_PLGN
mkdir $US_SRC_JAVA_PLGN
mkdir $US_SRC_DB_PLGN
mkdir $US_SRC_WEB_PLGN
mkdir $US_SRC_I18N_PLGN
mkdir $US_SRC_LIBS_PLGN

echo "  Copiando código fonte para compilação "
cp -r $US_SRC_OF_PATH/* $US_SRC_OF_PLGN
cp -r $US_SRC_JAVA_PATH/* $US_SRC_JAVA_PLGN
cp -r $US_SRC_DB_PATH/* $US_SRC_DB_PLGN
cp -r $US_SRC_WEB_PATH/* $US_SRC_WEB_PLGN
cp -r $US_SRC_I18N_PATH/* $US_SRC_I18N_PLGN
cp -r $US_SRC_LIBS_PATH/* $US_SRC_LIBS_PLGN


echo "  Iniciando compilação  "
cd $OF_BUILD_PATH
$OF_BUILD_CMD

echo ""
echo ""
echo ""
echo ""
echo " *******************************************"
echo "  Finalizando criação do jar"
echo " *******************************************"
echo ""
echo "  Descompactando arquivos compilados "
cd $OF_TARGT_PATH
unzip $US_PRMRY_NAME.jar -d $US_FINAL_NAME
cd $US_FINAL_NAME"/lib"
rm -f $US_LIB_TEMP1 $US_LIB_TEMP2

echo ""
echo "   Copiando classes compiladas para gerar jar"
echo ""
mkdir $US_CLASS_PLGN
mv $US_CLASS_PATH/* $US_CLASS_PLGN

mkdir $US_WEB_CLASS_PLUGIN
rsync -r $US_WEB_CLASS_PATH/* $US_CLASS_PLGN
rsync -r $US_WEB_JAVA_PATH/* $US_CLASS_PLGN

cp -r $US_SRC_WEB_PATH/* $US_WEB_PATH
cp -r $USER_STATUS_PATH"/plugin.xml" $US_PLGN_PATH

cd $US_PLGN_PATH
echo ""
echo "   Gerando arquivo jar"
echo ""
jar cf $US_FINAL_NAME.jar *
mv $US_FINAL_NAME.jar $USER_STATUS_PATH/
rm -rf $US_FINAL_NAME


echo ""
echo "   Limpando arquivos"
echo ""
rm -rf $OF_US_PLUGIN_PATH $OF_BUILD $OF_WORK

mv $OF_PLUGINS_BKP_PATH/* $OF_PLUGINS_PATH

