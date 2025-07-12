FROM python:3.10-alpine

WORKDIR /app
COPY requirements.txt /app
RUN pip install -r requirements.txt
COPY . /app

EXPOSE 8080

ENTRYPOINT ["python3"]
CMD ["main.py"]
