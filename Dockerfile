FROM node:10

RUN apt-get update && apt-get install build-essential

WORKDIR /app
ADD . /app
RUN npm install

RUN npm run build

CMD npm run serve-static
