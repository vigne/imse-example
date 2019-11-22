from config import Config

from flask import Flask
from flask_pymongo import PyMongo

api = Flask(__name__)
# load configuration module
api.config.from_object(Config)

# mongo connection
mongo = PyMongo(api)

from server import routes # bottom import is a workaround to circular imports
