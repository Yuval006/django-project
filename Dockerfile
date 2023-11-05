FROM python:3.9.18-slim as builder

WORKDIR /app

COPY ./django_web_app/requirements.txt .

RUN pip install -r requirements.txt

FROM python:3.9.18-slim as run

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

WORKDIR /django_web_app

COPY ./django_web_app .

RUN python manage.py makemigrations

RUN python manage.py migrate

ENTRYPOINT [ "python", "manage.py" , "runserver", "0.0.0.0:8000" ] 