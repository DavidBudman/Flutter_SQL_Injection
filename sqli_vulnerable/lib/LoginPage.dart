import 'package:flutter/material.dart';
import 'package:sqli_vulnerable/database.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _login({String username, String password}) async {
    // int id = await DBProvider.db.loginAndGetUserID(username, password).catchError((e) => setState(() => _errorMessage = e.toString()));
    try {
      int id = await DBProvider.db.loginAndGetUserID(username, password);
      if (id == -1) {
        setState(() { _errorMessage = "Username or Password is incorrect!"; });
      } else {
        //Navigator.pushReplacementNamed(context, '/student', arguments: {'username': username, 'userID': id});
        Navigator.pushNamed(context, '/student',
            arguments: {'username': username, 'userID': id});
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        // _errorMessage = "An error occurred.";
      });
    }
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        // backgroundColor: Colors.blue,
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              SizedBox(height: 80),
              Container(
                padding: EdgeInsets.all(6.0),
                width: 300,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Username'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.0),
                width: 300,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                    onPressed: () => _login(
                        username: _usernameController.text,
                        password: _passwordController.text),
                    child: Text('LOGIN')),
              ),
              SizedBox(height: 20.0),
              Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(_errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 20.0))))
            ])));
  }
}
