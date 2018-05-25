FROM python:3.6-stretch

WORKDIR /tests
COPY . .
RUN pip install -r requirements.txt

CMD robot --outputdir /results .
