#!/bin/bash

ydate=$(date -d '1 day ago' +"%dd/%mm/%YYYY")
cdate=`date +"%d_%m_%Y"`
DATE=`date +"%Y%m%d"`
rdir=`pwd`

DEVICE="$1"
SYNC="$2"
CLEAN="$3"
THREADS="$4"

# Start timinig
res1=$(date +%s.%N)

# Colorize and add text parameters
red=$(tput setaf 1)             #  red
grn=$(tput setaf 2)             #  green
cya=$(tput setaf 6)             #  cyan
txtbld=$(tput bold)             #  Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldylw=${txtbld}$(tput setaf 3) #  yellow
bldblu=${txtbld}$(tput setaf 4) #  blue
bldppl=${txtbld}$(tput setaf 5) #  purple
bldcya=${txtbld}$(tput setaf 6) #  cyan
txtrst=$(tput sgr0)             #  Reset

# we don't allow scrollback buffer
echo -e '\0033\0143'
clear
                                                                                                                                                                                                                                                                                                                                                                                                                               
echo -e $red""$txtrst"Team Lu4ndr01d - www.luandroid.com.br" "$bldppl" "

# Cleaning up the Mess here
if [ "$CLEAN" == "clean" ]
then
    echo -e "${cya}Limpando ${txtrst}"
    make clobber ;
    echo -e "Vamos começar a compilar !"
else
    echo -e "Não limpo"
fi

# Remove previous build info
echo "Removendo build.prop anterior"
rm out/target/product/"$DEVICE"/system/build.prop;

# Sync Latest Sources
if [ "$SYNC" == "sync" ]
then
    echo -e "${cya}Sincronizando Sources ${txtrst}"
    repo sync -j"$THREADS";
    echo -e "${cya}Ultimos Sources sincronizado ${txtrst}"
else
    echo -e "Iniciando a Compilação"
fi

export LA_PRODUCT="$DEVICE"

# Start the Build
echo -e "${bldblu}Configurando o ambiente de compilação ${txtrst}"
. build/envsetup.sh

# Lunch Specified Device
echo -e ""
echo -e "${bldblu}Executando o Lunch no seu aparelho ${txtrst}"
lunch "la_$DEVICE-userdebug";

echo -e ""
echo -e "${bldblu}Começando a compilar Sky Night ROM by Lu4ndr01d ${txtrst}"

# Let ReVolt start compiling
brunch "la_$DEVICE-userdebug" -j"$THREADS";

# Time elapsed for a full set of builds
res2=$(date +%s.%N)
echo "${bldgrn}Tempo total decorrido: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
