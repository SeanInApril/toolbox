#!/bin/bash

###############################################################
# pull.sh
# A script to pull new versions from git servers automatically
# in the current directory.
# Timestamp of last pull will be updated in pull_timestamp.
#
# Sean <SeanInApril@163.com>
###############################################################

#directories to be ignored, separated with space character
except="linux ecos"

dir=$(pwd)

module_skipped()
{
    for m in $except; do
	if [ $m = $1 ]; then
	    return 1
	fi
    done
    
    return 0
}

for d in $(ls -l | awk '/^d/{print $9}'); do
	module_skipped $d
	if [ $? -ne 1 ]; then
	    echo "****************************"
	    echo $d
	    echo "****************************"
	    echo "pull $dir/$d..."
	    cd ${dir}/$d; git pull; if [ $? -ne 0 ]; then exit 1; fi
	    echo "$d done"
	else
	    echo "$d is skipped"
	    continue
	fi
done

echo "last pull:"          >  $dir/pull_timestamp
echo $(date +%Y%m%d%H%M%S) >> $dir/pull_timestamp

echo ""
echo "all done!"
