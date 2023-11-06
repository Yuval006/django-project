docker build -t me-west1-docker.pkg.dev/django-project-test-404011/django-yuval/app .
docker run --name app -d -p 8000:8000 me-west1-docker.pkg.dev/django-project-test-404011/django-yuval/app:$1