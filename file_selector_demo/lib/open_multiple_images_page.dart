import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

/// Screen that shows an example of openFiles
class OpenMultipleImagesPage extends StatelessWidget {
  void _openImageFile(BuildContext context) async {
    final jpgsTypeGroup = XTypeGroup(
      label: 'JPEGs',
      extensions: ['jpg', 'jpeg'],
    );
    final pngTypeGroup = XTypeGroup(
      label: 'PNGs',
      extensions: ['png'],
    );
    final files = await openFiles(acceptedTypeGroups: [
      jpgsTypeGroup,
      pngTypeGroup,
    ]);
    if (files.isEmpty) {
      // Operation was canceled by the user.
      return;
    }
    await showDialog(
      context: context,
      builder: (context) => MultipleImagesDisplay(files),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open multiple images'),
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
              child: Text('Press to open multiple images (png, jpg)'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget that displays a text file in a dialog
class MultipleImagesDisplay extends StatelessWidget {
  /// The files containing the images
  final List<XFile> files;

  /// Default Constructor
  MultipleImagesDisplay(this.files);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Gallery'),
      // On web the filePath is a blob url
      // while on other platforms it is a system path.
      content: Center(
        child: Row(
          children: <Widget>[
            ...files.map(
              (file) => Flexible(
                  child: kIsWeb
                      ? Image.network(file.path)
                      : Image.file(File(file.path))),
            )
          ],
        ),
      ),
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
