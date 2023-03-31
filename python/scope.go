package main

import "fmt"

func main() {
	func() {
		a := 10
		fmt.Println(a)
	}()
	fmt.Println(a)
}
