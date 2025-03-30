FROM python:latest
WORKDIR /app

COPY docker-env .
RUN pip install -r requirements.txt
# CMD ["python", "example_dotenv.py", "&&", "tail", "-f", "/dev/null"]
