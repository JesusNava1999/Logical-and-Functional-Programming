/* Nava Cuellar José De Jesús
Bases de datos en Go y Programación Web */
package main

import (
	"database/sql"
	"log"
	"net/http"
	"text/template"

	_ "github.com/go-sql-driver/mysql"
)

func conexionBD() (conexion *sql.DB) {
	driver := "mysql"
	user := "root"
	password := "nava123"
	database := "carrito"

	conexion, err := sql.Open(driver, user+":"+password+"@tcp(127.0.0.1)/"+database)
	if err != nil {
		panic(err.Error())
	}
	return conexion
}

var plantillas = template.Must(template.ParseGlob("plantillas/*"))

func main() {
	http.HandleFunc("/", Inicio)
	http.HandleFunc("/crear", Crear)
	http.HandleFunc("/insertar", Insertar)
	http.HandleFunc("/borrar", Borrar)
	http.HandleFunc("/editar", Editar)
	http.HandleFunc("/actualizar", Actualizar)
	http.HandleFunc("/comprar", Comprar)
	http.HandleFunc("/vaciar", Vaciar)

	log.Println("Servidor corriendo")
	http.ListenAndServe(":8080", nil)
}

type Tienda struct {
	Id       int
	Nombre   string
	Cantidad int
	Costo    float64
}
type Sumar struct {
	Total float64
}

func Inicio(w http.ResponseWriter, r *http.Request) {
	conexionBD()

	registros, err := conexionBD().Query("SELECT * from productos")
	if err != nil {
		panic(err.Error())
	}
	producto := Tienda{}
	arreglproducto := []Tienda{}
	for registros.Next() {
		var id int
		var nombre string
		var cantidad int
		var costo float64
		err = registros.Scan(&id, &nombre, &cantidad, &costo)
		if err != nil {
			panic(err.Error())
		}
		producto.Id = id
		producto.Nombre = nombre
		producto.Cantidad = cantidad
		producto.Costo = costo
		arreglproducto = append(arreglproducto, producto)

	}

	plantillas.ExecuteTemplate(w, "inicio", arreglproducto)

}

func Crear(w http.ResponseWriter, r *http.Request) {
	plantillas.ExecuteTemplate(w, "crear", nil)
}

func Insertar(w http.ResponseWriter, r *http.Request) {
	if r.Method == "POST" {
		nombre := r.FormValue("nombre")
		cantidad := r.FormValue("cantidad")
		costo := r.FormValue("costo")
		conexionBD()
		insertarRegistros, err := conexionBD().Prepare("INSERT INTO productos(nombre, cantidad, costo) VALUES(?,?,?)")
		if err != nil {
			panic(err.Error())
		}
		insertarRegistros.Exec(nombre, cantidad, costo)
		http.Redirect(w, r, "/", 301)
	}
}

func Borrar(w http.ResponseWriter, r *http.Request) {
	idProducto := r.URL.Query().Get("id")
	log.Println("Eliminado: " + idProducto)
	conexionBD()
	borrarRegistro, err := conexionBD().Prepare("DELETE FROM productos WHERE id=?")
	if err != nil {
		panic(err.Error())
	}
	borrarRegistro.Exec(idProducto)
	http.Redirect(w, r, "/", 301)
}

func Editar(w http.ResponseWriter, r *http.Request) {
	idProducto := r.URL.Query().Get("id")
	log.Println("Editando " + idProducto)
	conexionBD()
	registro, err := conexionBD().Query("SELECT * from productos WHERE id=?", idProducto)

	if err != nil {
		panic(err.Error())
	}
	producto := Tienda{}
	arregloProducto := []Tienda{}
	for registro.Next() {
		var id int
		var nombre string
		var cantidad int
		var costo float64
		err = registro.Scan(&id, &nombre, &cantidad, &costo)
		if err != nil {
			panic(err.Error())
		}
		producto.Id = id
		producto.Nombre = nombre
		producto.Cantidad = cantidad
		producto.Costo = costo

		arregloProducto = append(arregloProducto, producto)
	}
	log.Println(producto)
	plantillas.ExecuteTemplate(w, "editar", producto)
}

func Actualizar(w http.ResponseWriter, r *http.Request) {
	if r.Method == "POST" {
		id := r.FormValue("id")
		nombre := r.FormValue("nombre")
		cantidad := r.FormValue("cantidad")
		costo := r.FormValue("costo")
		conexionBD()
		actualizarRegistros, err := conexionBD().Prepare("UPDATE productos SET nombre=?, cantidad=?, costo=? WHERE id=?")
		if err != nil {
			panic(err.Error())
		}
		actualizarRegistros.Exec(nombre, cantidad, costo, id)
		http.Redirect(w, r, "/", 301)
	}
}

func Comprar(w http.ResponseWriter, r *http.Request) {
	conexionBD()

	total, err := conexionBD().Query("SELECT SUM(costo) from productos")
	if err != nil {
		panic(err.Error())
	}
	tl := Sumar{}
	tl2 := []Sumar{}
	for total.Next() {
		var tl3 float64
		err = total.Scan(&tl3)
		if err != nil {
			panic(err.Error())
		}
		tl.Total = tl3
		tl2 = append(tl2, tl)
	}

	plantillas.ExecuteTemplate(w, "comprar", tl2)

}

func Vaciar(w http.ResponseWriter, r *http.Request) {
	conexionBD()
	borrarRegistro, err := conexionBD().Prepare("DELETE FROM productos")
	if err != nil {
		panic(err.Error())
	}
	borrarRegistro.Exec(borrarRegistro)
	http.Redirect(w, r, "/", 301)
}
