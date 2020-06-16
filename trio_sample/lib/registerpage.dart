import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';
import 'loadingscreen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff304059),
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Color(0xff8B80E6),
        centerTitle: true,
      ),
      body: RegisterContainer(),
    ));
  }
}

class RegisterContainer extends StatefulWidget {
  @override
  _RegisterContainerState createState() => _RegisterContainerState();
}

class _RegisterContainerState extends State<RegisterContainer> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstName = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController email = new TextEditingController();

  void _registerUser() async {
    //print(username.value.text);

    var userfirstname = firstName.text;

    var userpassword = password.text;

    var useremail = email.text;

    //print(userfirstname);
    submitDialog(context);

    http.Response response = await http.post(url, body: {
      "type": "userregistration",
      "firstname": userfirstname,
      "password": userpassword,
      "emailid": useremail,
    });
    Navigator.pop(context);
    print("ResPonse :" + response.body);
    var dataUser = json.decode(response.body);
    //print(dataUser);

    if (dataUser != 'Fail') {
      Navigator.pop(context);
      print("success");
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Phonenumber already exists')));
    }
  }

  validateField(value) {
    if (value.isEmpty) {
      return "Field is Empty";
    } else {
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    //   _fetchState();
    // _fetchCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: width,
            decoration: BoxDecoration(color: Color(0xff304059)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomInputWidget(
                  width: width,
                  hinttext: "Name",
                  controller: firstName,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Field is Empty";
                    } else {
                      return null;
                    }
                  },
                  prefixicon: Icons.person,
                ),
                CustomInputWidget(
                  width: width,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Field is Empty";
                    } else {
                      return null;
                    }
                  },
                  hinttext: "Enter Password",
                  controller: password,
                  prefixicon: Icons.lock,
                  obscure: true,
                ),
                CustomInputWidget(
                  width: width,
                  controller: email,
                  hinttext: "Email",
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Field is Empty";
                    } else {
                      return null;
                    }
                  },
                  prefixicon: Icons.email,
                  inputtype: TextInputType.emailAddress,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 200,
                  child: RaisedButton(
                    color: Color(0xff39DAF7),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        _registerUser();
                      } else {}
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already Registered?",
                        style: TextStyle(color: Color(0xff7D8CA1)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(color: Color(0xff39DAF7)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomInputWidget extends StatelessWidget {
  final hinttext;
  final prefixicon;
  final obscure;
  final inputtype;
  final controller;
  final validator;
  const CustomInputWidget({
    Key key,
    this.hinttext,
    this.obscure,
    this.controller,
    this.inputtype,
    this.validator,
    this.prefixicon,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      child: TextFormField(
        controller: controller,
        validator: this.validator,
        style: TextStyle(color: Colors.white),
        obscureText: obscure != null ? obscure : false,
        keyboardType: inputtype != null ? inputtype : TextInputType.text,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff7D8CA1))),
            prefixIcon: Icon(
              prefixicon,
              color: Color(0xff7D8CA1),
            ),
            hintText: hinttext,
            hintStyle: TextStyle(color: Color(0xff7D8CA1))),
      ),
    );
  }
}
