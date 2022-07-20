#!/bin/sh

WORKING_DIRECTORY=$1
LAYER_NAME=$2
RUNTIME=$3
ADDITIONAL_RUNTIMES=$4

# change to working directory
cd ./$WORKING_DIRECTORY
echo "PWD = $(pwd)"

FILE="requirements.txt"

if [ ! -f $FILE ]; then
    echo "ERROR: Could not find a $FILE at $PWD"
	exit 1
fi

# pip install requirements
pip install -r requirements.txt -t python/lib/$RUNTIME/site-packages/
if [ $? -ne 0 ] ; then
    echo "ERROR: Failed pip install requirements"
    exit 1
fi

# create zip package with layer dependencies
zip -r layer.zip python > /dev/null
if [ $? -ne 0 ] ; then
    echo "ERROR: Failed creating zip package"
    exit 1
fi

# Publish lambda layer to AWS and store the JSON output as publish_layer_output
publish_layer_output=$(aws lambda publish-layer-version --layer-name $LAYER_NAME --zip-file fileb://layer.zip --compatible-runtimes $RUNTIME $ADDITIONAL_RUNTIMES | jq --compact-output '.')
ret=$?
if [ $ret -ne 0 ] ; then
    echo "ERROR: Failed aws lambda publish-layer-version"
    exit $ret
fi

# Set Github Action output
echo "::set-output name=output::${publish_layer_output}"
