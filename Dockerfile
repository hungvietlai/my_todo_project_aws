FROM python:3.10-alpine
RUN apk update && apk add --no-cache \
    libffi-dev \
    openssl-dev \
WORKDIR /opt/app/
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
COPY todo_app/fetch_secrets.py /opt/app/fetch_secrets.py
EXPOSE 5000
ENV FLASK_ENV=production
CMD [ "python", "todo_app/app.py" ]