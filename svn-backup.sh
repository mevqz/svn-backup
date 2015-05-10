#!/bin/bash  
# Copyright (C) 2013  Matías E. Vazquez (matiasevqz@gmail.com)  
      
# This program is free software; you can redistribute it and/or  
# modify it under the terms of the GNU General Public License  
# as published by the Free Software Foundation; either version 2  
# of the License, or (at your option) any later version.  
      
# This program is distributed in the hope that it will be useful,  
# but WITHOUT ANY WARRANTY; without even the implied warranty of  
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  
# GNU General Public License for more details.  
      
# You should have received a copy of the GNU General Public License  
# along with this program; if not, write to the Free Software  
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.  
      
SAVEIFS=$IFS  
IFS=$(echo -en "\n\b")  
      
# change this to the corresponding path
rpath="/PATH/TO/REPO/"  
dumppath="$rpath.bsvndump/"  
dumplog="svndump.log"  
      
if [ ! -d "$rpath" ]; then  
	exit;  
fi  
      
mkdir -p $dumppath  
cd $dumppath  
rm *  
      
repos=`ls $rpath`  
printf "System date: %s\n" "`date`" >> "$dumplog"  
for rd in $repos  
do  
	printf "\nsvnadmin dump %s%s\n" $rpath$rd >> "$dumplog"  
	svnadmin dump "$rpath$rd" 2>> "$dumplog" > "$rd.dump"  
done  
      
OF=svndump-$(date +%d_%m_%Y).tgz  
tar -czf "$OF" *  
rm "$dumplog"  
rm *.dump  
      
IFS=$SAVEIFS  
