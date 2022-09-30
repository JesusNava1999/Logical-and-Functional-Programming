package main

import "fmt"

func main() {
	var n int
	fmt.Print("Ingrese tamaño de n: ")
	fmt.Scanf("%d", &n)
	k := n
	p := 0
	for i := 1; i <= n; i++ {
		if i == 1 {
			for j := 1; j <= n; j++ {
				fmt.Print(j)
			}
		} else {
			for j := k + 1; j <= n; j++ {
				fmt.Print(j)
			}
			for m := 1; m <= n-p; m++ {
				fmt.Print(m)
			}
		}
		k--
		p++
		fmt.Println()
	}
}
