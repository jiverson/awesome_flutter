import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

/// Screen that shows an example of getDirectoryPath
class GetDirectoryPage extends StatelessWidget {
  void _getDirectoryPath(BuildContext context) async {
    final confirmButtonText = 'Choose';
    final directoryPath = await getDirectoryPath(
      confirmButtonText: confirmButtonText,
    );
    if (directoryPath == null) {
      // Operation was canceled by the user.
      return;
    }
    await showDialog(
      context: context,
      builder: (context) => TextDisplay(directoryPath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open a directory folder'),
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
              onPressed: () => _getDirectoryPath(context),
              child: Text('Press to ask user to choose a directory'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget that displays a text file in a dialog
class TextDisplay extends StatelessWidget {
  /// Directory path
  final String directoryPath;

  /// Default Constructor
  TextDisplay(this.directoryPath);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Selected Directory'),
      content: Scrollbar(
        child: SingleChildScrollView(
          child: Text(directoryPath),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
