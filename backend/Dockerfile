FROM ubuntu
WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y python3 python3-pip

RUN adduser app

USER app

RUN pip3 install -r requirements.txt

CMD ["python3", "app.py"]