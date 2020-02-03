FROM node

WORKDIR /code

RUN npm install -g express-generator

ADD . /code

ENTRYPOINT ["bash", "/code/builder/scripts/start.sh"]
