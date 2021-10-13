FROM python:3.8.12-alpine3.14
RUN mkdir -p /app
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
RUN python app_test.py
ENTRYPOINT ["python"]
CMD ["app.py"]