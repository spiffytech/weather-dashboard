FROM node:10

RUN npm install yarn

WORKDIR /app
ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json
RUN npm install

ADD . /app

CMD npm run serve
