/* NAVA CUELLAR JOSÉ DE JESÚS
Práctica 2.5 Ahorcado en Go */
package main

import (
	"fmt"
	"math/rand"
	"os"
	"os/exec"
	"strings"
	"time"
)

func main() {
	palabras := [20]string{"calabaza", "aburrimiento", "yegua", "consumir", "mediocampo", "atletismo", "programar", "cabello", "polimorfismo", "realidad", "musculos", "comunismo", "velador", "traductor", "natacion", "delantal", "dibujar", "capataz", "espalda", "sonrisa"}
	ahorcado := []string{"'  +---+\n  |   |\n      |\n      |\n      |\n      |\n========='", "'  +---+\n  |   |\n  O   |\n      |\n      |\n      |\n========='" /*  "'  +---+\n  |   |\n  O   |\n  |   |\n      |\n      |\n========='", */, "'  +---+\n  |   |\n  O   |\n /|   |\n      |\n      |\n========='" /* "'  +---+\n  |   |\n  O   |\n /|\\  |\n      |\n      |\n========='", */, "'  +---+\n  |   |\n  O   |\n /|\\  |\n /    |\n      |\n========='", "'  +---+\n  |   |\n  O   |\n / \\  |\n /|\\  |\n      |\n========='"}

	s1 := rand.NewSource(time.Now().UnixNano())
	r1 := rand.New(s1)
	word := palabras[r1.Intn(20)]

	qChar := len([]rune(word))
	rand1 := 1 + r1.Intn(qChar-1)
	rand2 := 1 + r1.Intn(qChar-1)
	rand3 := 1 + r1.Intn(qChar-1)
	rand4 := 1 + r1.Intn(qChar-1)
	word2 := word
	char1 := word2[rand1]
	char2 := word2[rand2]
	char3 := word2[rand3]
	char4 := word2[rand4]
	word2 = strings.ReplaceAll(word2, string(word2[rand1]), "_")
	word2 = strings.ReplaceAll(word2, string(word2[rand2]), "_")
	word2 = strings.ReplaceAll(word2, string(word2[rand3]), "_")
	word2 = strings.ReplaceAll(word2, string(word2[rand4]), "_")

	lose := false
	win := false
	times := 0
	var input string
	data := []byte(word2)

	for (!lose) && (!win) {
		cmd := exec.Command("cmd", "/c", "cls")
		cmd.Stdout = os.Stdout
		cmd.Run()
		println("Juego del ahorcado :)\n\n")
		if times == 0 {
			println(ahorcado[times])
		} else if times == 1 {
			println(ahorcado[times])
		} else if times == 2 {
			println(ahorcado[times])
		} else if times == 3 {
			println(ahorcado[times])
		}
		println("\n", string(data))

		fmt.Scan(&input)
		if input == string(char1) {
			for i := 0; i < qChar; i++ {
				if word[i] == char1 {
					if string(data[i]) == input {
						times++
					}
					data[i] = char1
				}
			}
			println(string(data))
		} else if input == string(char2) {
			for i := 0; i < qChar; i++ {
				if word[i] == char2 {
					if string(data[i]) == input {
						times++
					}
					data[i] = char2
				}
			}
			println(string(data))
		} else if input == string(char3) {
			for i := 0; i < qChar; i++ {
				if word[i] == char3 {
					if string(data[i]) == input {
						times++
					}
					data[i] = char3
				}
			}
			println(string(data))
		} else if input == string(char4) {
			for i := 0; i < qChar; i++ {
				if word[i] == char4 {
					if string(data[i]) == input {
						times++
					}
					data[i] = char4
				}
			}
			println(string(data))
		} else {
			times++
		}

		if word == string(data) {
			win = true
		}

		if times >= 4 {
			lose = true
		}
	}
	if win {
		cmd := exec.Command("cmd", "/c", "cls")
		cmd.Stdout = os.Stdout
		cmd.Run()
		println("GANASTE :)")
		println(word)
	}
	if lose {
		cmd := exec.Command("cmd", "/c", "cls")
		cmd.Stdout = os.Stdout
		cmd.Run()
		println("PERDISTE :(")
		println(ahorcado[4])
		println("La palabra era:", word)
	}
}
