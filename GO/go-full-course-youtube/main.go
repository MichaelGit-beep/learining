package main

import "fmt"

func main() {
	// a := []byte("Hello")
	b := []byte{'H', 'L'}

	for _, v := range b {
		fmt.Println(string(v))
	}
}
