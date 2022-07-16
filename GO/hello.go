package main

import (
	"fmt"
)

func some(a ...int) {
	fmt.Println(a)
}

func main() {
	some([]int{1, 2, 3, 4, 5}...)
}
