from prometheus_client import Counter, start_http_server, Gauge
from flask import Flask

REQUESTS = Counter('http_requests_total',
                   'Total number of requests', labelnames=['path', 'method'])
ERRORS = Counter('http_errors_total',
                 'Total number of errors', labelnames=['code'])
IN_PROGRESS = Gauge('inprogress_requests',
                    'Total number of requests in progress')

def before_request():
    IN_PROGRESS.inc()

def after_request(response):
    IN_PROGRESS.dec()
    return response


app = Flask(__name__)


@app.get("/products")
def get_products():
    REQUESTS.labels('products', 'get').inc()
    return "product"


@app.post("/products")
def create_product():
    REQUESTS.labels('products', 'post').inc()
    return "created product", 201

@app.get("/cart")
def get_cart():
    REQUESTS.labels('cart', 'get').inc()
    return "cart"


@app.post("/cart")
def create_cart():
    REQUESTS.labels('cart', 'post').inc()
    return "created cart", 201


@app.errorhandler(404)
def page_not_found(e):
    ERRORS.labels('404').inc()
    return "page not found", 404


if __name__ == '__main__':
    start_http_server(8000)
    app.run(debug=False, host="0.0.0.0", port='5000')