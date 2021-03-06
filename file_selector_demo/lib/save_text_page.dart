import 'dart:typed_data';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

/// Page for showing an example of saving with file_selector
class SaveTextPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _saveFile() async {
    var path = await getSavePath();
    if (path == null) {
      // Operation was canceled by the user.
      return;
    }
    final text = _contentController.text;
    final fileName = _nameController.text;
    final fileData = Uint8List.fromList(text.codeUnits);
    final fileMimeType = 'text/plain';
    final textFile =
        XFile.fromData(fileData, mimeType: fileMimeType, name: fileName);
    await textFile.saveTo(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save text into a file'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              child: TextField(
                minLines: 1,
                maxLines: 12,
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: '(Optional) Suggest File Name',
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                minLines: 1,
                maxLines: 12,
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: 'Enter File Contents',
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              onPressed: () => _saveFile(),
              child: Text('Press to save a text file'),
            ),
          ],
        ),
      ),
    );
  }
}
