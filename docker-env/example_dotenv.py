# Libraries 
import os
# import sys
from dotenv import load_dotenv

# Confirm modules imported 
modules = dir()

print(modules)
print(os.environ)



# Load Kaggle credentials
load_dotenv()

KAGGLE_USERNAME = os.getenv('KAGGLE_USERNAME')
KAGGLE_KEY = os.getenv('KAGGLE_KEY')

if KAGGLE_USERNAME is not None:
    print('KAGGLE_USERNAME is loaded')

if KAGGLE_KEY is not None:
    print('KAGGLE_KEY is loaded')
    
    
