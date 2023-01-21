package main

import "fmt"

func lookup(m map[string]int64, k string) interface{} {
	a, ok := m[k]
	if ok {
		return a
	}
	return nil
}

func main() {
	a := map[string]int64{"NY": 255}
	fmt.Println(lookup(a, "NG"))
}
