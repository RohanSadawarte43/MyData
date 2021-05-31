import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/src/file_picker.dart';
import 'package:my_info/api/FirebaseApi.dart';
import 'package:my_info/api/FirebaseApiD.dart';
import 'package:my_info/model/Firebase_file.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadMultipleImageDemo extends StatefulWidget {
  @override
  _UploadMultipleImageDemoState createState() =>
      _UploadMultipleImageDemoState();
}

class _UploadMultipleImageDemoState extends State<UploadMultipleImageDemo> {
  UploadTask task;
  File file;
  String filename = "Select a file from device";
  String uploadText = "Click to upload";
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
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return UploadMultipleImageDemo();
              } else {
                final files = snapshot.data;
                return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        'Important Files',
                        style: TextStyle(
                          fontSize: 25,
                        )
                        ,),
                      backgroundColor: Colors.grey[800],
                      centerTitle: true,
                      
                    ),
                    body: Container(
                        color: Colors.grey[900],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              child: Text(
                                'Upload',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[800],
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[850], spreadRadius: 3),
                                ],
                              ),
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            ),
                            SizedBox(
                              height: 20,
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
                            task != null
                                ? buildUploadStatus(task)
                                : Container(),
                            Text(
                              uploadText,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              child: Text(
                                'Download',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[800],
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[850], spreadRadius: 3),
                                ],
                              ),
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: files.length,
                                  itemBuilder: (context, index) {
                                    final file = files[index];
                                    return buildFile(context, file);
                                  }),
                            ),
                            SizedBox(height: 20,)
                          ],
                        )));
              }
          }
        });
  }

  Future download2(Dio dio, String url, String savePath) async {
    Response response = await dio.get(
      url,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
  }

  Widget buildFile(BuildContext context, FirebaseFile file) {
    return (ListTile(
      title: Text(
        (file.name).split(".")[0],
        style: TextStyle(
          color: Colors.amberAccent,
          fontSize: 18,
        ),
      ),
      leading: Container(
        color: Colors.grey[800],
        child: IconButton(
            icon: Icon(Icons.file_download),
            splashColor: Colors.white,
            color: Colors.black,
            onPressed: () async {
              String name = file.name;
              final Reference ref =
                  FirebaseStorage.instance.ref().child("files/$name");
              if (await Permission.storage.request().isGranted) {
                String path =
                    await ExtStorage.getExternalStoragePublicDirectory(
                        ExtStorage.DIRECTORY_DOWNLOADS);
                String url = (await ref.getDownloadURL()).toString();
                String fullPath = "$path/$name";
                var dio = Dio();
                download2(dio, url, fullPath);
              }
            }),
      ),
    ));
  }

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
    setState(() => {uploadText = ""});

    if (task == null) {
      return null;
    }
    final snapshot = await task.whenComplete(() => null);
    final urlDownload = await snapshot.ref.getDownloadURL();
  }

  buildUploadStatus(UploadTask task) => StreamBuilder(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress =
                ((snap.bytesTransferred / snap.totalBytes) * 100).toString();

            return (Text(
              '$progress % Uploaded',
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
