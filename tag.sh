#!/bin/bash
#TAG the local IMAGES to REPO name and PUSH it to Registry
#USAGE ./tag.sh reponame
reponame="$1"
#output of docker image will be in imagefile, which has only the REPOSITORY column
docker images | awk '{print $1;}' | sed 1d > imagefile

input="imagefile"
while IFS= read -r line; do
    [[ $line == $reponame* ]]  && ignore="yes"
    [[ $line != $reponame* ]]  && docker tag $line $reponame/$line && docker push $reponame/$line
done < "$input"
