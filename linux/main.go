package main

import (
	"fmt"
)

type dbClient struct {
	data *int
}

type some struct {
	client *dbClient
}

func main() {
	a := some{
		&dbClient{},
	}
	fmt.Println(*(a.client).data)
}
