/* Nava Cuellar José De Jesús
Nombre del archivo: palindromo.go */

package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	palabra := bufio.NewScanner(os.Stdin)
	mismaLetra := 0
	aux := 0
	fmt.Print("Palabra a Evaluar: ")
	palabra.Scan()
	caracteres := palabra.Text()

	for i := len(caracteres) - 1; i >= 0; i-- {
		if caracteres[aux] == caracteres[i] {
			mismaLetra++
		}
		aux++
	}
	if len(caracteres) == mismaLetra {
		fmt.Println("SI es Palindromo")
	} else {
		fmt.Println("NO es Palindromo")
	}
}
