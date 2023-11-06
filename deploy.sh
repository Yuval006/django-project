#!/bin/bash


deploy(){
VERSION=$1
# Error handling must get 2 inputs from user
if [ $# -lt 1 ]
then
    echo "USAGE: $0 '<version>' "
    exit 1
fi

docker build -t me-west1-docker.pkg.dev/django-project-test-404011/django-yuval/app:$VERSION .


# Error handling: Checks if build is completed succefuly
if [ $? -eq 0 ]
then 
    echo
    echo "Build Succeeded/Exists"
    source '/google-cloud-sdk/path.bash.inc'
    source '/google-cloud-sdk/completion.bash.inc'
    gcloud auth configure-docker me-west1-docker.pkg.dev
    docker push me-west1-docker.pkg.dev/django-project-test-404011/django-yuval/app:$VERSION
else
    echo "Error: Build failed, Fix Dockerfile and try again"
fi


}

deploy $1