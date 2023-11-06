docker build -t jenkins_image .
docker run --name app -d -p 8000:8000 jenkins_image