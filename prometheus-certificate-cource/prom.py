from prometheus_client import start_http_server, Gauge, Enum, Counter
import time
import random


class AppMetrics:
    def __init__(self):
        self.http_total_requests = Counter("code:http_total_requests", "")
        self.http_requests = Gauge("http_requests", "", ["code", "method"])
        self.http_errors = Gauge("http_errors", "", ["code", "method", "path"])
        self.methods = ("get", "put", "delete")
        self.codes = ("500", "300", "200")
        self.paths =  ("/db", "/api", "/logs")

    def run_metrics_loop(self):
        while True:
            self.http_total_requests.inc()
            for code, method, path in zip(self.codes, self.methods, self.paths):
                self.http_requests.labels(code, method).inc()
                self.http_errors.labels(code, method, path).inc()
            time.sleep(5)


app_metrics = AppMetrics()
start_http_server(9877)
app_metrics.run_metrics_loop()