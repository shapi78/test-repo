FROM python:latest

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY example_dotenv.py .

ENV KAGGLE_USERNAME=ofirgaash_username
ENV KAGGLE_KEY=ofirs_key

CMD ["python", "example_dotenv.py"]
