/* Nava Cuellar José De Jesús
Nombre del archivo: raices.go  */

package main

import (
	"fmt"
	"html/template"
	"net/http"
	"strconv"
)

func NewtonRaphson(x float64, comienzo int, margen float64) float64 {
	var resp float64 = 0
	var z float64
	var dif float64
	if comienzo == 1 {
		z = 1
	}
	if comienzo == 0 {
		z = x
	}
	z = (z + 2/z) / 2
	dif = x - z

	if dif > margen {
		resp = NewtonRaphson(z, 0, margen)
	} else {
		resp = z
	}
	return resp
}

func raices(w http.ResponseWriter, r *http.Request) {
	fmt.Println("method:", r.Method)
	if r.Method == "GET" {
		t, _ := template.ParseFiles("raices.html")
		t.Execute(w, nil)
	} else {
		r.ParseForm()
		a, err := strconv.ParseFloat(r.FormValue("a"), 64)
		if err != nil {
		}
		b, err := strconv.ParseFloat(r.FormValue("b"), 64)
		if err != nil {
		}
		c, err := strconv.ParseFloat(r.FormValue("c"), 64)
		if err != nil {
		}
		raiz_1 := -b + NewtonRaphson(b*b-4*a*c, 1, 0.0000001)/(2*a)
		raiz_2 := -b - NewtonRaphson(b*b-4*a*c, 1, 0.0000001)/(2*a)

		a1 := int(a)
		b1 := int(b)
		c1 := int(c)
		raiz_1_1 := int(raiz_1)
		raiz_2_1 := int(raiz_2)

		fmt.Fprintf(w, "<h1>Las raices cuadradas de %dx² + %dx + %d son: %d y %d</h1>", a1, b1, c1, raiz_1_1, raiz_2_1)

	}
}

func main() {
	http.HandleFunc("/", raices)
	http.ListenAndServe(":8080", nil)
}
