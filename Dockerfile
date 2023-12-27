FROM caddy:alpine

# install node and npm
RUN apk update && apk add --no-cache nodejs npm

# set working directory
WORKDIR /app

# copy package.json and package-lock.json into workdir
COPY package*.json ./

# install project dependencies
RUN npm install

# copy application code
COPY . .

# build app
RUN npm run build

# copy built files to caddy srv directory
RUN cp -r dist/* /srv/

# copy caddyfile
COPY ./Caddyfile /etc/caddy/Caddyfile