FROM node

WORKDIR /code
ADD . /code

RUN npm install

EXPOSE 3000

ENTRYPOINT ["node", "/code/bin/www"]