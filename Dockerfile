# Define first phase => /app/build - all the files
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

###########################################

# Define second phase => copy build files in the nginx container
# If AWS deploy fails use unamed phase
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

