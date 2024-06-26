FROM python:3.8
ENV MONGODB_CONNSTRING="mongodb://localhost:27017"
COPY ./app_atlas.py /deploy/
COPY ./requirements.txt /deploy/
COPY ./templates /deploy/templates/
COPY ./static/css /deploy/static/css/
WORKDIR /deploy/
RUN pip3 install -r requirements.txt
EXPOSE 5000
ENTRYPOINT ["python", "app_atlas.py"]
