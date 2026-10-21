FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get
COPY . .
RUN flutter build web --release

FROM nginx:1.27-alpine
COPY --from=build /app/build/web /usr/share/nginx/html
COPY render/nginx.conf.template /etc/nginx/templates/default.conf.template
ENV PORT=10000
EXPOSE 10000
