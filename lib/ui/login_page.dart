import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _editingPhoneController = TextEditingController();
  final TextEditingController _editingPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: _editingPhoneController,
              decoration: InputDecoration(
                labelText: "Fill Phone No",
                border: OutlineInputBorder()
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            TextFormField(
              controller: _editingPasswordController,
              decoration: InputDecoration(
                  labelText: "Fill Password",
                  border: OutlineInputBorder()
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            SizedBox(
              width: double.infinity,
              child:  RaisedButton(
                padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                onPressed: (){
                  Toast.show("Login", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                  ),
                ),
                color: Colors.redAccent,

              ),
            )
          ],
        ),
      ),
    );
  }
}
