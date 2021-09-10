import 'dart:async';

import 'package:bookshop/src/model/books.dart';
import 'package:bookshop/src/pages/loginSingUp/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bookshop/src/pages/screen_book.dart';
import 'package:bookshop/src/pages/information_book.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ListBooks extends StatefulWidget {
  @override
  _books createState() => _books();
}

final bookRef = FirebaseDatabase.instance.reference().child('books');

class _books extends State<ListBooks> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser!;
    await firebaseUser.reload();
    firebaseUser = _auth.currentUser!;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  List<book> items = [];
  StreamSubscription<Event>? addBooks;
  StreamSubscription<Event>? changeBooks;

  @override
  void initState() {
    super.initState();
    items = [];
    addBooks = bookRef.onChildAdded.listen(_addBooks);
    changeBooks = bookRef.onChildChanged.listen(_updateBooks);
    this.checkAuthentification();
    this.getUser();
  }

  @override
  void dispose() {
    super.dispose();
    addBooks!.cancel();
    changeBooks!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff6b2f90),
          title: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 20),
              children: [
                WidgetSpan(
                  child:
                      Icon(Icons.book_outlined, size: 33, color: Colors.white),
                ),
                TextSpan(
                    text: " BOOKSHOP ", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    signOut();
                  },
                  child: Icon(Icons.arrow_back),
                )),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return GestureDetector(
                      onTap: () => infolibroS(context, items[index]),
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 18, right: 18, top: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff6b2f90),
                              Color(0xff9070c7),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(4, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.book,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '${items[index].genero}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'avenir'),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    icon: Icon(Icons.edit),
                                    color: Colors.white,
                                    tooltip: 'Información',
                                    onPressed: () {
                                      editLibro(context, items[index]);
                                    }),
                              ],
                            ),
                            Text(
                              'Autor: ${items[index].autor}',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'avenir'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '${items[index].nombre}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.white,
                                    tooltip: 'Borrar',
                                    onPressed: () {
                                      deletelibro(context, items[index], index);
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 20),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Agregar',
              style: TextStyle(color: Color(0xff6b2f90), fontSize: 17)),
          icon: Icon(Icons.book_outlined, color: Color(0xff6b2f90)),
          backgroundColor: Color(0xfff7dc11),
          onPressed: () => agregarBook(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void agregarBook(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScreenBooks(
          bookD: book(),
        ),
      ),
    );
  }

  void _addBooks(Event event) {
    print(Iterable.empty());
    setState(() {
      items.add(book.fromSnapShot(event.snapshot));
    });
  }

  void _updateBooks(Event event) {
    var oldBook = items.singleWhere((book) => book.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldBook)] = book.fromSnapShot(event.snapshot);
    });
  }

  void editLibro(BuildContext context, book book) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScreenBooks(bookD: book),
      ),
    );
  }

  void infolibroS(BuildContext context, book book) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Infolibro(bookI: book),
      ),
    );
  }

  void deletelibro(BuildContext context, book book, int position) async {
    await bookRef.child(book.id!).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
}
