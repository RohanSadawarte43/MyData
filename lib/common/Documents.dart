import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/src/file_picker.dart';
import 'package:my_info/api/FirebaseApi.dart';
import 'package:my_info/api/FirebaseApiD.dart';
import 'package:my_info/model/Firebase_file.dart';
import 'package:my_info/pages/image_page.dart';

class UploadMultipleImageDemo extends StatefulWidget {
  @override
  _UploadMultipleImageDemoState createState() =>
      _UploadMultipleImageDemoState();
}

class _UploadMultipleImageDemoState extends State<UploadMultipleImageDemo> {
  UploadTask task;
  File file;
  String filename = "Select a file from device";
  Future<List<FirebaseFile>> futureFiles;

  initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApiD.listAll('files/');
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    return FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
            if(snapshot.hasError){
              return Center(child: Text('Some Error'),);  
            }else {
              final files = snapshot.data;
          return Container(
              color: Colors.grey[900],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Upload',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  RaisedButton(
                      color: Colors.grey[700],
                      onPressed: selectFile,
                      child: Text(
                        'Select',
                        style: TextStyle(color: Colors.black),
                      )),
                  Text(
                    filename,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                      color: Colors.grey[700],
                      onPressed: uploadFile,
                      child: Text(
                        'Upload',
                        style: TextStyle(color: Colors.black),
                      )),
                  task != null ? buildUploadStatus(task) : Container(),
                  Text(
                    'Download',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  buildHeader(files.length),
                  SizedBox(height: 12,),
                  Expanded(child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index){
                      final file = files[index];
                      return buildFile(context, file);
                    }
                    ),)
                ],
              ));
                }
          }
        });
  }

    Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          file.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      return;
    }
    final path = result.files.single.path;

    setState(() => {
          filename = result != null ? path.split("/").last : "No File Selected"
        });
    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async {
    if (file == null) {
      return;
    }
    final destination = 'files/$filename';
    task = FirebaseApi.uploadFile(destination, file);
    setState(() {});

    if (task == null) {
      return null;
    }
    final snapshot = await task.whenComplete(() => null);
    final urlDownload = await snapshot.ref.getDownloadURL();

    print("Download : $urlDownload");
  }

  buildUploadStatus(UploadTask task) => StreamBuilder(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress =
                ((snap.bytesTransferred / snap.totalBytes) * 100).toString();

            return (Text(
              '$progress % Done',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ));
          } else {
            return Container();
          }
        },
      );
}
