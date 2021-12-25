package main

import (
	"fmt"
)

func main() {
	a := [4]string{"5", "6", "7", "8"}
	for i, v := range a {
		fmt.Println(i, v)
	}
}
