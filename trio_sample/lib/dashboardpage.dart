import 'package:flutter/material.dart';
import 'loadingscreen.dart';
import 'dart:convert';
import 'constants.dart';
import 'dashboardpage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<bool> setUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString("userid", null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff304059),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: "Logout",
            onPressed: () {
              setUserId();
              Navigator.pop(context);
            }),
        title: Text("Dashboard"),
        backgroundColor: Color(0xff8B80E6),
        centerTitle: true,
      ),
      body: DashboardContainer(),
    ));
  }
}

class DashboardContainer extends StatefulWidget {
  @override
  _DashboardContainerState createState() => _DashboardContainerState();
}

class _DashboardContainerState extends State<DashboardContainer> {
  String username;
  String email;
  fetchdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authtoken = prefs.getString('userid');
    print(authtoken);

    http.Response dashresponse = await http.get(
        "http://18.130.82.119:3030/api/v1/dashboard?auth_token=" + authtoken);

    //print("dasboard :" + dashresponse.body);

    var dataUser = json.decode(dashresponse.body);
    print(dataUser);

    setState(() {
      username = dataUser["name"];
      email = dataUser["email"];
    });
    // Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "Hi " +
              (username == null ? "" : username) +
              ", Your Email Id is " +
              (email == null ? "" : email),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
