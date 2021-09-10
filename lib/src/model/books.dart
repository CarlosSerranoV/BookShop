import 'package:firebase_database/firebase_database.dart';

class book {
  String? id;
  String? nombre;
  String? editorial;
  String? idioma;
  String? autor;
  String? paginas;
  String? fechaPubli;
  String? genero;


  book(
      {this.id,
      this.nombre,
      this.editorial,
      this.idioma,
      this.autor,
      this.paginas,
      this.fechaPubli,
      this.genero});

  //Mapeo para estructurar los datos
  book.map(dynamic obj) {
    this.nombre = obj['nombre'];
    this.editorial = obj['editorial'];
    this.idioma = obj['idioma'];
    this.autor = obj['autor'];
    this.paginas = obj['paginas'];
    this.fechaPubli = obj['fechaPubli'];
    this.genero = obj['genero'];

  }

  //Getters de las variables

  String get getId => id!;
  String get getNombre => nombre!;
  String get getEditoria => editorial!;
  String get getIdioma => idioma!;
  String get getAutor => autor!;
  String get getPaginas => paginas!;
  String get getDechaPubli => fechaPubli!;
  String get getGenero => genero!;


  book.fromSnapShot(DataSnapshot snapshot) {
    id = snapshot.key;
    nombre = snapshot.value['nombre'];
    editorial = snapshot.value['editorial'];
    idioma = snapshot.value['idioma'];
    autor = snapshot.value['autor'];
    paginas = snapshot.value['paginas'];
    fechaPubli = snapshot.value['fechaPubli'];
    genero = snapshot.value['genero'];

  }
}
