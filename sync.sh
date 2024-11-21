#!/bin/bash
###################################################

##################################################
# script de synchronisation de fichier local vers serveur et vis-versa
# Developper par Mohamed cisse
# version 1.0
# date 20/11/2024 a Bamako
##################################################

##################################################

#FONCTION HELP 
help(){
echo "syntax: sync -s <nom_du_serveur> -r <chemin du dossier distant a synchroniser> -l <chemin_local_destination> -u (du local vers serveur ) "
echo "options:"
echo ""
echo "   -s: pour specifier le serveur distant"
echo "   -r: pour specifier le dossier distant a synchroniser"
echo "   -l: pour specifier le dossier local de destination"
echo "   -u: pour le chargement de local -> serveur (upload)"
echo "   -d: pour activer le daemon de surveillance"
} 
mode=false
daemon=false
while getopts "s:r:l:ud" option ;do
case $option in
s)
server=$OPTARG
;;
r)
rrep=$OPTARG
;;
l)
lrep=$OPTARG
;;
u)
mode=true
;; 
d)
daemon=true
;;
*)
help
;;
esac
done

#pour verifier l"entrer de commande 
if [[ -z $server || -z $rrep || -z $lrep ]]; then
help

elif [ "$mode" == "true" ];then
#local vers server
echo "upload"
echo "synchronisation en cours: local vers server ..........................."
rsync -avz "$lrep/" "$server:$rrep/"
else
#serveur vers local
echo "download"
echo "synchronisation en cours: serveur vers local .........................."
rsync -avz "$server:$rrep/" "$lrep/"
fi
