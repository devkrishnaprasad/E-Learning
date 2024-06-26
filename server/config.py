from dotenv import load_dotenv
import os
from datetime import timedelta

load_dotenv()

class ApplicationConfig:
    SECRET_KEY = os.environ["TOKEN_SECRET_KEY"]
    JWT_ACCESS_TOKEN_EXPIRES = timedelta(hours=2)