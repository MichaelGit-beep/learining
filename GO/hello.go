package main

import "fmt"

func main() {
	fmt.Println(test(25))
}

func test(x int) int {
	return x % 2
}
