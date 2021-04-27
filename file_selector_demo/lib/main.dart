import 'package:flutter/material.dart';
import 'package:jiverson_fileselectordemo_app/home_page.dart';
import 'package:jiverson_fileselectordemo_app/get_directory_page.dart';
import 'package:jiverson_fileselectordemo_app/open_text_page.dart';
import 'package:jiverson_fileselectordemo_app/open_image_page.dart';
import 'package:jiverson_fileselectordemo_app/open_multiple_images_page.dart';
import 'package:jiverson_fileselectordemo_app/save_text_page.dart';

void main() {
  runApp(MyApp());
}

/// MyApp is the Main Application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Selector Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        '/open/image': (context) => OpenImagePage(),
        '/open/images': (context) => OpenMultipleImagesPage(),
        '/open/text': (context) => OpenTextPage(),
        '/save/text': (context) => SaveTextPage(),
        '/directory': (context) => GetDirectoryPage(),
      },
    );
  }
}
