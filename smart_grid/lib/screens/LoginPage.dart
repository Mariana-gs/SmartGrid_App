import 'package:smart_grid/screens/AuthManager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signWithEmailAndPasswaord(
        email: _controllerEmail.text,
        password: _controllerPassword.text
      );
    } on FirebaseAuthException catch (e){

      setState((){
        errorMessage = e.message;
      });

    }

  }

  Future<void> createUserWithEmailAndPassword() async {

    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text
      );
    } on FirebaseAuthException catch (e){

      setState(){
        errorMessage = e.message;
      }
    }
  }

  Widget _title(){

    return const Text('Firebase Auth');

  }


  Widget _entryField(
    String title,
    TextEditingController controller,
  ){

    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(color: Colors.white, fontFamily: 'Inter'),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(24.0), // Arredonda a borda em 24 graus
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA988F9)), // Cor de seleção roxa
          borderRadius: BorderRadius.circular(24.0), // Arredonda a borda em 24 graus
        ),
        focusColor: Color(0xFFA988F9), // Cor de seleção roxa
        hoverColor: Color(0xFFA988F9), // Cor de seleção roxa ao passar o mouse
      
    
      //ecoration: InputDecoration(
        //labelText: title,
      )
    );
  }

  Widget _errorMessage(){
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF4EFE9), // Cor de fundo F4EFE9
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      ),
      onPressed:
      isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login': 'Register', style: TextStyle(color: Colors.black, fontFamily: 'Inter')),
    );
  }

  Widget _loginOrRegisterButton(){
    return TextButton(
      onPressed: (
      ){
        setState((){
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead', style: TextStyle(color: Color(0xFFA988F9)),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B1B1D),
      //appBar: AppBar(
        //title: _title(),
      //),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Login', style: TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 36)),
            SizedBox(height: 16.0),

            _entryField('Email', _controllerEmail),
            SizedBox(height: 16.0),

            _entryField('Password', _controllerPassword),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton(),
          ]
        ),
      ),
    );
  }
}
