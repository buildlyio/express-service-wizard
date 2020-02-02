FROM node

WORKDIR /code

RUN npm install -g express-generator

ADD . /code

ENTRYPOINT ["bash", "/code/scripts/create_app.sh"]
