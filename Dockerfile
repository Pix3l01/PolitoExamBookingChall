FROM python:3.9
RUN apt-get update
COPY ./app .
COPY ./requirements.txt .

RUN pip install -r requirements.txt
ENTRYPOINT ["python", "-u", "main.py"]