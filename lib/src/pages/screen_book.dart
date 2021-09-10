import 'package:bookshop/src/model/books.dart';
import 'package:bookshop/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

//nuevo para imagenes
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';

class ScreenBooks extends StatefulWidget {
  final book bookD;
  const ScreenBooks({Key? key, required this.bookD}) : super(key: key);

  @override
  _ScreenBookState createState() => _ScreenBookState();
}

final bookReference = FirebaseDatabase.instance.reference().child('books');

class _ScreenBookState extends State<ScreenBooks> {
  List<book> items = [];
  TextEditingController? nombreController;
  TextEditingController? editorialController;
  TextEditingController? idiomaController;
  TextEditingController? autorController;
  TextEditingController? paginasController;
  TextEditingController? fechaPubliController;
  TextEditingController? generoController;

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }
  //fin nuevo imagen

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.bookD.nombre);
    editorialController = TextEditingController(text: widget.bookD.editorial);
    idiomaController = TextEditingController(text: widget.bookD.idioma);
    autorController = TextEditingController(text: widget.bookD.autor);
    paginasController = TextEditingController(text: widget.bookD.paginas);
    fechaPubliController = TextEditingController(text: widget.bookD.fechaPubli);
    generoController = TextEditingController(text: widget.bookD.genero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personas en la base de datos'),
        backgroundColor: Color(0xff6b2f90),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Image.asset('assets/imgs/newbook.png'),
                  ),
                  TextField(
                    controller: nombreController,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    decoration: InputDecoration(
                        icon: Icon(Icons.book), labelText: 'Nombre'),
                    keyboardType: TextInputType.text,
                  ),
                  Padding(padding: EdgeInsets.only(top: 8.0)),
                  Divider(),
                  TextField(
                    controller: editorialController,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    decoration: InputDecoration(
                        icon: Icon(Icons.text_snippet_rounded),
                        labelText: 'Editorial'),
                    keyboardType: TextInputType.text,
                  ),
                  Padding(padding: EdgeInsets.only(top: 8.0)),
                  Divider(),
                  TextField(
                    controller: idiomaController,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    decoration: InputDecoration(
                      icon: Icon(Icons.translate_sharp),
                      labelText: 'Idioma',
                    ),
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                  ),
                  Padding(padding: EdgeInsets.only(top: 8.0)),
                  Divider(),
                  TextField(
                    controller: autorController,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_pin_rounded),
                      labelText: 'Autor',
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  Padding(padding: EdgeInsets.only(top: 8.0)),
                  Divider(),
                  TextField(
                    controller: paginasController,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    decoration: InputDecoration(
                      icon: Icon(Icons.format_list_numbered),
                      labelText: 'Paginas',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Padding(padding: EdgeInsets.only(top: 8.0)),
                  Divider(),
                  TextField(
                    controller: fechaPubliController,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today_rounded),
                      labelText: 'Fecha Publicación',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  Padding(padding: EdgeInsets.only(top: 8.0)),
                  Divider(),
                  TextField(
                    controller: generoController,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    decoration: InputDecoration(
                      icon: Icon(Icons.theater_comedy_outlined),
                      labelText: 'Genero',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  Divider(),
                  TextButton(
                      onPressed: () async {
                        //nuevo image
                        if (widget.bookD.id != null) {
                          await bookReference.child(widget.bookD.id!).set({
                            'nombre': nombreController!.text,
                            'editorial': editorialController!.text,
                            'idioma': idiomaController!.text,
                            'autor': autorController!.text,
                            'paginas': paginasController!.text,
                            'fechaPubli': fechaPubliController!.text,
                            'genero': generoController!.text,
                          }).then((_) => {Navigator.pop(context)});
                        } else {
                          await bookReference.push().set({
                            'nombre': nombreController!.text,
                            'editorial': editorialController!.text,
                            'idioma': idiomaController!.text,
                            'autor': autorController!.text,
                            'paginas': paginasController!.text,
                            'fechaPubli': fechaPubliController!.text,
                            'genero': generoController!.text,
                          }).then((_) => {Navigator.pop(context)});
                        }
                      },
                      child: (widget.bookD.id != null)
                          ? Text('Guardar')
                          : Text('Agregar')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
