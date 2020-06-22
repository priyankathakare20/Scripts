#!/bin/bash

# Script cleans up old builds on Jenkins

usage()
{
        echo ""
        echo "Usage $0 pathAndNameOfJob startBuild endBuild base64EncodedAuthString"
        echo  "For example: ./cleanup.sh dev-ui%20dev 1 100 longstringvalue"
        exit 1

}

if [ $# != 4 ]; then
        usage
fi

JOB_NAME=$1
BUILD_START=$2
BUILD_END=$3
AUTH=$4

# Makes sure build args are numbers
re='^[0-9]+$'
if ! [[ $BUILD_START =~ $re ]] ; then
           echo "error: Not a number: " $BUILD_START;
           usage
fi

if ! [[ $BUILD_END =~ $re ]] ; then
           echo "error: Not a number: " $BUILD_END;
           usage
fi

# Get Jenkins Crumb
JENKINS_CRUMB=`curl -H  "Authorization: Basic $AUTH" "https://newspage-replatform-stage-2.jenkins.adop.accenture.com/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)"`

echo "Got Jenkins Crumb: $JENKINS_CRUMB"

# Call delete
DELETE_PREFIX="https://newspage-replatform-stage-2.jenkins.adop.accenture.com/job/"
DELETE_SUFFIX="/doDelete"

for i in $(seq $BUILD_START $BUILD_END); do
        echo "Deleting build $i"
        CMD=`curl -v -d "" -H "Authorization: Basic $AUTH" -X POST "https://newspage-replatform-stage-2.jenkins.adop.accenture.com/job/$JOB_NAME/$i/doDelete" -H "$JENKINS_CRUMB"`
done
