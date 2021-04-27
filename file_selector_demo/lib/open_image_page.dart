import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

/// Screen that shows an example of openFiles
class OpenImagePage extends StatelessWidget {
  void _openImageFile(BuildContext context) async {
    final typeGroup = XTypeGroup(
      label: 'images',
      extensions: ['jpg', 'png'],
    );
    final files = await openFiles(acceptedTypeGroups: [typeGroup]);
    if (files.isEmpty) {
      // Operation was canceled by the user.
      return;
    }
    final file = files[0];
    final fileName = file.name;
    final filePath = file.path;

    await showDialog(
      context: context,
      builder: (context) => ImageDisplay(fileName, filePath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open an image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              onPressed: () => _openImageFile(context),
              child: Text('Press to open an image file(png, jpg)'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget that displays a text file in a dialog
class ImageDisplay extends StatelessWidget {
  /// Image's name
  final String fileName;

  /// Image's path
  final String filePath;

  /// Default Constructor
  ImageDisplay(this.fileName, this.filePath);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(fileName),
      // On web the filePath is a blob url
      // while on other platforms it is a system path.
      content: kIsWeb ? Image.network(filePath) : Image.file(File(filePath)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
