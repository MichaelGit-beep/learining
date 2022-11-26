package main

import "fmt"

type human struct {
	name string
}

func (h human) some() {
	fmt.Println("name:", h.name)
}

func main() {
	a := []interface{}{"1", "a", 1, 2.0, true}
	fmt.Println(len(a))
	b := a[0 : len(a)-1]
	b = b[0:1]
	fmt.Println(b, a)
}
