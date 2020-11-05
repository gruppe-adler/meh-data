#!/bin/sh
set -e

toolsDir=$(dirname $0)

rm -f Dockerfile
touch Dockerfile

cp $toolsDir/.dockerignore .

for directory in */ ; do
    worldName=$(basename $directory)

    export WORLD_NAME=$worldName
    envsubst \$WORLD_NAME < $toolsDir/Dockerfile.map 1>> Dockerfile
    unset WORLD_NAME
done

cat $toolsDir/Dockerfile.head 1>> Dockerfile

for directory in */ ; do
    worldName=$(basename $directory)

    echo "COPY --from=$worldName /out $worldName" 1>> Dockerfile
done
