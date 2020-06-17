import 'package:flutter/material.dart';
import 'registerpage.dart';
import 'loadingscreen.dart';
import 'dart:convert';
import 'dashboardpage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff304059),
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Color(0xff8B80E6),
        centerTitle: true,
      ),
      body: LoginContainer(),
    ));
  }
}

class LoginContainer extends StatefulWidget {
  @override
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _statusmsg = "";

  void validateLogin() async {
    String username = _username.text;
    String password = _password.text;
    //submitDialog(context);
    if (_formKey.currentState.validate()) {
      //print(username.value.text);
      //print(userfirstname);

      submitDialog(context);
      Map data = {
        "email": username,
        "password": password,
      };
      // Map data = {"email": "hanson@gmail.com", "password": "123"};

      var body = json.encode(data);

      http.Response response = await http.post(
          "http://18.130.82.119:3030/api/v1/sign_in",
          headers: {"Content-Type": "application/json"},
          body: body);

      // print("ResPonse :" + response.body);

      var dataUser = json.decode(response.body);

      //print(dataUser["user-token"]);

      // Map data = {"email": "hanson@gmail.com", "password": "123"};

      Navigator.pop(context);
      //Navigator.pop(context);

      //var dataUser = json.decode(response.body);

      // print(dataUser["user-token"]);

      //Navigator.pop(context);
      if (dataUser["auth_token"] != null) {
        // setUserId(dataUser[0]["Id"]);
        setUserId(dataUser["auth_token"]);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DashboardPage()));
        _username.text = "";
        _password.text = "";
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Login Failed')));
      }
    }
    // Navigator.pop(context);
  }

  Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString("userid", value);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          width: width,
          decoration: BoxDecoration(color: Color(0xff304059)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(50),
                child: CircleAvatar(
                  backgroundColor: Color(0xff3C5068),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  ),
                  radius: 50,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: width - 80,
                child: TextFormField(
                  controller: _username,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Username is required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff7D8CA1))),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xff7D8CA1),
                    ),
                    hintText: "Enter Email id",
                    hintStyle: TextStyle(color: Color(0xff7D8CA1)),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: width - 80,
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Password is required";
                    } else {
                      return null;
                    }
                  },
                  controller: _password,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff7D8CA1))),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xff7D8CA1),
                      ),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Color(0xff7D8CA1))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "" + _statusmsg,
                style: TextStyle(color: Colors.red.shade200),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                child: RaisedButton(
                  color: Color(0xff39DAF7),
                  onPressed: () {
                    validateLogin();
                  },
                  child: Text(
                    "Authenticate",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have Account?",
                    style: TextStyle(color: Color(0xff7D8CA1)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterPage()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Color(0xff39DAF7)),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "",
                    style: TextStyle(color: Color(0xff7D8CA1)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
