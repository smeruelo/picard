FROM node:14.8 as builder
WORKDIR /app
COPY . /app
RUN yarn install \
	&& yarn build \
	&& ./node_modules/.bin/parcel build index.html

FROM nginx:latest
COPY --from=builder /app/dist /usr/share/nginx/html
COPY ./webserver/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx-debug", "-g", "daemon off;"]
