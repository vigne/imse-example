from server import api
from server import routes # bottom import is a workaround to circular imports

if __name__ == '__main__':
    api.debug = False
    api.run(host = api.config.get('FLASK_HOST'), port=5000)
