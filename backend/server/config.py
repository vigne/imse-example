import os

class Config(object):
    # as Docker creates the user in the admin database and we're using the slr database, authSource has to be provided
    MONGO_URI = os.environ.get('MONGO_URI') or 'mongodb://admin:imse@localhost:27017/slr?authSource=admin'
    TOKEN_EXP = 3600
