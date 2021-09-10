import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignUp.dart';
import 'package:bookshop/src/pages/home.dart';
import 'package:bookshop/src/pages/loginSingUp/header/header.dart';
import 'package:bookshop/src/pages/loginSingUp/header/logo.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListBooks()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email!, password: _password!);
      } on FirebaseAuthException catch (e) {
      print(e);
      String errorMes = "";
      if (e.code == 'user-not-found') {
        errorMes = 'Ningun usuario encontrado con el email.';
      } else if (e.code == 'wrong-password') {
        errorMes = 'Contraseña incorrecta';
      } else if (e.code == 'too-many-requests') {
        errorMes = 'Demasiados peticiones';
      }
      showError(errorMes);
    }
        
      
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.only(top: 0),
      physics: BouncingScrollPhysics(),
      children: [
        Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  HeaderLogin(),
                  LogoHeader(),
                ],
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
                  child: Row(
                    children: [
                      Text('LOG IN',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Text('/',
                          style: TextStyle(fontSize: 25, color: Colors.grey)),
                      TextButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => SignUp())),
                          child: Text('SIGN UP',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)))
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(left: 18, right: 18, top: 18),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              filled: true,
                              fillColor: Color(0xffEBDCFA),
                              prefixIcon:
                                  Icon(Icons.mail_outline, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffEBDCFA)),
                                  borderRadius: BorderRadius.circular(50)),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffEBDCFA)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onSaved: (input) => _email = input),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              filled: true,
                              fillColor: Color(0xffEBDCFA),
                              prefixIcon: Icon(Icons.visibility_off,
                                  color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffEBDCFA)),
                                  borderRadius: BorderRadius.circular(50)),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffEBDCFA)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onSaved: (input) => _password = input),
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                        onPressed: login,
                        child: Text('LOGIN',
                            style: TextStyle(
                                color: Color(0xff6b2f90),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        color: Color(0xfff7dc11),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child: Text('Crear cuenta'),
                onTap: navigateToSignUp,
              )
            ],
          ),
        ),
      ],
    ));
  }
}
