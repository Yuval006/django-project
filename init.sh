docker build -t me-west1-docker.pkg.dev/django-project-test-404011/django-yuval/app .
docker run -d -p 8000:8000 --name app me-west1-docker.pkg.dev/django-project-test-404011/django-yuval/app:$1