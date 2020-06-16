import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'dashboardpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('userid');
  print(email);
  runApp(MaterialApp(
    home: email == null ? LoginPage() : DashboardPage(),
    debugShowCheckedModeBanner: false,
  ));
}
