package main

import (
	"fmt"
<<<<<<< HEAD
	"sort"
)

func main() {
	a := []int{1991, 22, 3}
	sort.Sort(sort.IntSlice(a))
	fmt.Println(a)
=======
<<<<<<< HEAD
	"time"
)

func main() {
	s := make(chan int)
	go func() {
		time.Sleep(time.Second * 1)
		s <- 20
	}()

	select {
=======
	"strings"
)

func main() {
	l := []string{"a", "b", "c", "d", "e"}
	fmt.Println(strings.Join(l, ""))
}
>>>>>>> a02f8ae (123)

	case a := <-s:
		// s <- 1
		fmt.Println(a)
	default:
		fmt.Println("Default")
	}
>>>>>>> e47de196ed455e5dab50ecbe341710ab75eea174
}
