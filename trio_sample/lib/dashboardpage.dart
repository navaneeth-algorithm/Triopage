import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "Hi User, Your Email Id is user@gmail.com",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
