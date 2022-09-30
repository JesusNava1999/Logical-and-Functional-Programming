/* Nava Cuellar José De Jesús
Nombre del archivo: primos.go */

package main

import (
	"fmt"
	"time"
)

func primo(n int) bool {
	if n == 0 {
		return false
	} else if n == 1 {
		return false
	} else if n == 2 {
		return false
	}
	for i := 2; i < n/2; i++ {
		if n%i == 0 {
			return false
		}
	}
	return true
}

func rango(a int, b int) {
	if a != b+1 {
		if primo(a) {
			time.Sleep(10 * time.Millisecond)
			print(a, " ")
		}
		rango(a+1, b)
	}
}

func main() {
	n := 0
	fmt.Scanf("%v\n", &n)
	go rango(0, n/2)
	rango(n/2+1, n)
}
