# Legitimate Dockerfile for Happy Service
FROM fedora:42

WORKDIR /app

COPY happy-service.sh ./

RUN chmod +x happy-service.sh

EXPOSE 3000

CMD ["./happy-service.sh"]