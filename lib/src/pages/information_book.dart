import 'package:bookshop/src/model/books.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Infolibro extends StatefulWidget {
  final book bookI;

  Infolibro({Key? key, required this.bookI}) : super(key: key);

  @override
  _InfobookState createState() => _InfobookState();
}

final bookRef = FirebaseDatabase.instance.reference().child('books');

class _InfobookState extends State<Infolibro> {
  List<book>? items;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Información de Libro'),
        backgroundColor: Color(0xff6b2f90),
      ),
      body: Container(
        height: 500.0,
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Image.asset('assets/imgs/book.png'),
              ),
              SizedBox(height: 20),
              Text(
                'Nombre: ${widget.bookI.nombre}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              SizedBox(height: 20),
              Text(
                'Editorial: ${widget.bookI.editorial}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              SizedBox(height: 20),
              Text(
                'Idioma: ${widget.bookI.idioma}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              SizedBox(height: 20),
              Text(
                'Autor: ${widget.bookI.autor}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              SizedBox(height: 20),
              Text(
                'paginas: ${widget.bookI.paginas}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Fecha Publicación: ${widget.bookI.fechaPubli}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Genero: ${widget.bookI.genero}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
