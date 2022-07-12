package main

import (
	"fmt"
	"time"
)

func main() {
	s := make(chan int)
	go func() {
		time.Sleep(time.Second * 1)
		s <- 20
	}()

	select {

	case a := <-s:
		// s <- 1
		fmt.Println(a)
	default:
		fmt.Println("Default")
	}
}
