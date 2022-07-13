package main

import (
	"fmt"
	"sort"
)

func main() {
	a := []int{1991, 22, 3}
	sort.Sort(sort.IntSlice(a))
	fmt.Println(a)
}
