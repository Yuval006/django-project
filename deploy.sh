#!/bin/bash


choice_func(){
    read -r -n 1 -p "Enter Y|y or N|n: " choice
    while [[ $choice != 1 && $choice != 0 ]] 
    do
        if [[ $choice == [Yy] ]]; then
                choice=0
            elif [[ $choice == [Nn] ]]; then
                choice=1
            else
                echo "Invalid input, Try again."    
        fi
    done
}



deploy(){
VERSION=$1
# Error handling must get 2 inputs from user
if [ $# -lt 1 ]
then
    echo "USAGE: $0 '<version>' "
    exit 1
fi

choice=0
# Tag & Build thin.dockerfile if not exists

if docker images -a | grep -E "^me-west1-docker\.pkg\.dev/django-project-test-404011/django-yuval:$VERSION$" &> /dev/null 
then
    echo "Image me-west1-docker.pkg.dev/django-project-test-404011/django-yuval/app:$VERSION already exists."
    echo
    echo "Use the existing image - [N|n] or rebuild and delete the existing one - [Y|y]"
    choice_func
fi

if [ $choice = 0 ]
then
    docker rmi me-west1-docker.pkg.dev/django-project-test-404011/django-yuval/app:$1
    docker build -t me-west1-docker.pkg.dev/django-project-test-404011/django-yuval/app:$VERSION .
fi
# Error handling: Checks if build is completed succefuly
if [ $? -eq 0 ]
then 
    echo
    echo "Build Succeeded/Exists"
    echo "Push to GCR?"
    choice_func
    if [ $choice = 0 ]
    then 
        docker push me-west1-docker.pkg.dev/django-project-test-404011/django-yuval/app:$VERSION
    fi
else
    echo "Error: Build failed, Fix Dockerfile and try again"
fi


}

deploy $1