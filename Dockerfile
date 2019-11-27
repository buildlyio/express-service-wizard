FROM node

WORKDIR /code

RUN npm install -g express-generator

ADD . /code

ENTRYPOINT ["express", "--no-view", "--git", "YourExpressApplication"]
