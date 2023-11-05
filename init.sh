docker build -t django_img .
docker run -d -p 8000:8000 -v ./django_web_app/db.sqlite3:/django_web_app/db.sqlite3 --name app django_img