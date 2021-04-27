import 'package:flutter/material.dart';

/// Home Page of the application
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      primary: Colors.blue,
      onPrimary: Colors.white,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('File Selector Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: style,
              onPressed: () => Navigator.pushNamed(context, '/open/text'),
              child: Text('Open a text file'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: style,
              onPressed: () => Navigator.pushNamed(context, '/open/image'),
              child: Text('Open an image'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: style,
              onPressed: () => Navigator.pushNamed(context, '/open/images'),
              child: Text('Open multiple images'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: style,
              onPressed: () => Navigator.pushNamed(context, '/save/text'),
              child: Text('Save a file'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: style,
              onPressed: () => Navigator.pushNamed(context, '/directory'),
              child: Text('Open a get directory dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
