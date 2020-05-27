#!/bin/sh

touch /tmp/maya-tech-support

while read line; do
		echo "# $line" >> /tmp/maya-tech-support.$$
		$line >> /tmp/maya-tech-support.$$ 2>> /tmp/maya-tech-support.$$
		done <<EOF
kubectl version
kubectl get nodes
kubectl get bd -A -owide
kubectl get crd
kubectl get ns
kubectl get all -n openebs
kubectl get pods -A -owide
kubectl get sp
kubectl get spc
kubectl get csp
kubectl get ns
kubectl get pvc -A
kubectl get bdc -A
kubectl get pv
kubectl get cvr -A
kubectl get pods -n openebs -owide
kubectl describe all -n openebs
kubectl get pods -n maya-system -owide
kubectl describe all -n maya-system
EOF

cat <<EOF >> /tmp/maya-tech-support.$$


MW0c'...,dXMMMMMMMMMMMMMMMMMWO:....,dKWM
Xo.  .'.  ,kNMMMMMMMMMMMMMMXo.  .'.  'dX
, .cOXNXk, .oNMMMMMMMMMMMMX: .;kNNXx,  c
 .oNMMMMMXc .kWMMMMMMMMMMWo .dNMMMMMX: .
 '0MMMMMMMX: ;KMMMMMMMMMM0' lNMMMMMMWo  
 .OMMMMMMMMk..xWMMMMMMMMWo '0MMMMMMMWo  
  lNMMMMMMMX; cNMMMMMMMMK, lNMMMMMMMX;  
. .OMMMMMMMWo '0MMMMMMMMk. dMMMMMMMWd. ,
:  :XMMMMMMMd .kMMMMMMMWo .OMMMMMMM0' .d
0'  lNMMMMMNl .xWMWXOXWNc ,KMMMMMMX:  cX
Wk. .oNMMMMk.  'oxdl::x0; '0MMMMMXc  '0M
MWd. .lXMMXl....;'.''..,. .xMMMMX:  .kWM
MMNo   cKMXl:ldXXX0xox0kc;,dWMWO,  .xWMM
MMMXl   'kNo'lKMMMMWNNWMW0;;KXd.  .dWMMM
MMMMNo.  .,. 'xO00KKOlc00o,.'.   .xWMMMM
MMMMW0,      .....,od, ';.       :KMMMMM
MMMNx'                            'OWMMM
MMWd.                              .kWMM
MM0'     .,:,.            .;:,.     ;XMM
MWx.   .lKWWWKo.        ,xXWMN0l.   .OMM
MWl   'OWMXklcdx,      'clxNMMMWd.  .OMM
MMk.  lNMX:   ;ko.        'xkOWMK,  .kMM
MMO.  .oXk.   ..             ;KKl.  ;KMM
MM0,    .;.                  ,;.    cNMM
MMNc                                cNMM
MMNc                               .dWMM
MMWo            ..',,'.            .kMMM
MMMk.        'cx0XNWWNKOd:.        .OMMM
MMMO.      ,oONMMMMMMMMMMXkc.      ;KMMM
MMMNc    .:;..,xWMMMMMMNd'..;;.   .dWMMM
MMMMO'  .xx.   ;KMMMMMMk.   'xd.  ,KMMMM
MMMMWd..xWNd'   lXMMMM0;  .;OWNo .kWMMMM
MMMMMXc:KMMMNOo;;kWMMNo,;o0NMMM0;oNMMMMM
MMMMMMkcOWKkOKNWNWMMMWNNWN0xxXWkc0MMMMMM
MMMMMMXdcx0Ol;;codkkkxdl:;;lkOdlOWMMMMMM
MMMMMMMW0doddo:;,......,:lodookNMMMMMMMM
MMMMMMMMMMN0dlccc::::::ccclx0NMMMMMMMMMM
EOF


cat /tmp/maya-tech-support.$$ | gzip -c > ./maya-tech-support.gz
