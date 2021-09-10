import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookshop/src/pages/loginSingUp/login.dart';
import 'package:bookshop/src/pages/loginSingUp/header/header.dart';
import 'package:bookshop/src/pages/loginSingUp/header/logo.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name, _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email!, password: _password!);
        if (user != null) {
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser!.updateProfile(displayName: _name);
          // await Navigator.pushReplacementNamed(context,"/") ;
          print(_email);
        }
      } catch (handleError) {
        showError(handleError.toString());
        print(handleError);
        print('hola');
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
                  HeaderSignUp(),
                  LogoHeader(),
                ],
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
                  child: Row(
                    children: [
                      Text('SIGN IN',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Text('/',
                          style: TextStyle(fontSize: 25, color: Colors.grey)),
                      TextButton(
                          onPressed: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => Login())),
                          child: Text('LOG IN',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)))
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(18),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) return 'Enter Name';
                            },
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Nombre',
                              filled: true,
                              fillColor: Color(0xffEBDCFA),
                              prefixIcon: Icon(
                                  Icons.supervised_user_circle_rounded,
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
                            onSaved: (input) => _name = input),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) return 'Enter Email';
                            },
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
                            validator: (input) {
                              if (input!.length < 6)
                                return 'Provide Minimum 6 Character';
                            },
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
                        onPressed: signUp,
                        child: Text('SignUp',
                            style: TextStyle(
                                color: Color(0xff6b2f90),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        color: Color(0xfff7dc11),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
