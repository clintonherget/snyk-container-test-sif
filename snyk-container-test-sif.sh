#!/bin/bash

if [[ $# -ne 1 ]] ; then
    echo 'Usage: snyk-container-test-sif.sh SIF_FILE'
    exit 0
fi

SINGULARITY="singularity"
SQFS2TAR="sqfs2tar"
STACKER="stacker"
SNYK="snyk"

FILE_SIF=$1
FILE_BASE=$(basename -s .sif $FILE_SIF)
FILE_SQFS=${FILE_BASE}.squashfs
FILE_TAR=${FILE_BASE}.tar
FILE_OCI=${FILE_BASE}_oci.tar
FILE_YAML=${FILE_BASE}.yaml
WORKDIR=$(pwd)

LAYER=$($SINGULARITY sif list $FILE_SIF | grep quashfs | cut -f 1 -d ' ')
$SINGULARITY sif dump $LAYER $FILE_SIF > $FILE_SQFS

$SQFS2TAR $FILE_SQFS > $FILE_TAR

echo "first:
  from:
    type: tar
    url: $WORKDIR/$FILE_TAR" > $FILE_YAML

$STACKER build -f $FILE_YAML
cd oci
tar -czf ../$FILE_OCI .
cd ..

$SNYK container test oci-archive:$FILE_OCI

rm -rf $FILE_TAR $FILE_SQFS $FILE_YAML oci/ roots/
