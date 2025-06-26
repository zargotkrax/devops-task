FROM python:alpine3.17
WORKDIR /app
COPY . /app
COPY helloapp/ /app
RUN pip install -r requirements.txt

EXPOSE 8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "-w", "2", "helloapp.app:app"]