package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var pingCounter = prometheus.NewCounter(
	prometheus.CounterOpts{
		Name: "ping_request_count",
		Help: "No of request handled by Ping handler",
	},
)

func main() {
	prometheus.MustRegister(pingCounter)

	http.HandleFunc("/ping", func(w http.ResponseWriter, req *http.Request) {
		pingCounter.Inc()
		fmt.Fprintf(w, "pong")
	})
	http.Handle("/metrics", promhttp.Handler())
	log.Fatal(http.ListenAndServe(":8090", nil))
}
