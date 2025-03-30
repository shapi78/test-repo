FROM python:latest
WORKDIR /app

COPY docker-env .
RUN pip install -r requirements.txt

ENV KAGGLE_USERNAME="lubin"
ENV KAGGLE_KEY="1234"

#CMD ["tail", "-f", "/dev/null"]
CMD ["python" ,"example_dotenv.py"]