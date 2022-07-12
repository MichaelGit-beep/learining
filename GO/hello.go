package main

import (
	"fmt"
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
}
