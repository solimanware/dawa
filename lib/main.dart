import 'package:dawa/pages/drug.dart';
import 'package:flutter/material.dart';

void main() {
  //function to run the app takes widget as parameter
  //MaterialApp is a boiler plate from cross platform mobile material design prinsibles and components
  runApp(MaterialApp(
    debugShowCheckedModeBanner:false,
    title: 'Dawa Pro',
    theme: ThemeData(
      // Define the default Brightness and Colors
      brightness: Brightness.light,
      primaryColor: Colors.purple,
      accentColor: Colors.cyan[600],

      // Define the default Font Family
      fontFamily: 'Montserrat',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    ),
    home: Scaffold(
      body: DrugPage()
    ),
  ));
}