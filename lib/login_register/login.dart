import 'package:durga_pooja/shared_resources/authenticate.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function changeScreen;
  LoginPage({this.changeScreen});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Authenticate authenticate = Authenticate();
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Container(
        color: Colors.lightBlue[200],
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text(
                  "Pooja",
                  style: TextStyle(
                    fontSize: 55.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "App",
                  style: TextStyle(
                    fontSize: 55.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                ),
                validator: (val) {
                  String ans;
                  if (val.isEmpty) {
                    ans = "Please type in your email";
                  }
                  return ans;
                },
                onSaved: (val) => _email = val,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                ),
                validator: (val) {
                  String ans;
                  if (val.length < 5) {
                    ans = "Your password is less than 5 characters long";
                  }
                  return ans;
                },
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.white,
                onPressed: () async {
                  final formState = _formKey.currentState;
                  if (formState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    formState.save();
                    dynamic res = await authenticate.signIn(_password, _email);
                    if (res == null) {
                      setState(() {
                        error = "Incorrect Email/Password\n/Did not register";
                        loading = false;
                      });
                    } else {
                      setState(() {
                        error = res;
                      });
                    }
                  }
                },
                child: Text("Sign in"),
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red[800]),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.lightBlue,
                textColor: Colors.white,
                onPressed: () {
                  widget.changeScreen();
                },
                child: Text("Create an Account?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
