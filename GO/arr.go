package main

import "fmt"

func main() {
	a := []int{1, 2, 3, 4}
	a = append(a[0:1], a[1+1:]...)
	fmt.Println(a[0])
}
