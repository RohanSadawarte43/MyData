import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/src/file_picker.dart';
import 'package:my_info/api/FirebaseApi.dart';
import 'package:my_info/api/FirebaseApiD.dart';
import 'package:my_info/model/Firebase_file.dart';
import 'package:my_info/pages/image_page.dart';
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
    final imgURL ="https://firebasestorage.googleapis.com/v0/b/my-docs-6fc8c.appspot.com/o/files%2FApplied%20Machine%20Learning%20in%20Python.pdf?alt=media&token=da9d29d9-7d87-44ef-aab4-5304a7643816";
    var dio = Dio();
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
                    ),
                    ),
                    RaisedButton(
                      color: Colors.grey[700],
                      onPressed:()async{
                        if (await Permission.storage.request().isGranted) {
                        // getPermission();
                        String path = await ExtStorage.getExternalStoragePublicDirectory(
                          ExtStorage.DIRECTORY_DOWNLOADS);
                          // String fullPath = "$path/rohan1.pdf";
                          print("hiiiii.0");
                          downloadFile("https://firebasestorage.googleapis.com/v0/b/my-docs-6fc8c.appspot.com/o/files%2FRohan_Sadawarte_VIIT?alt=media&token=fb3ca194-34cf-4f6c-886e-19a06939f140","RohanFlutter","/storage/emulated/0/Download");
                          print("hiiiii.1");
                          // download2(dio, imgURL,fullPath);
                          // 
                        }
                      },
                      child: Text(
                        'Download',
                        style: TextStyle(color: Colors.black),
                      )
                      ),
                ],
              ));
                }
          }
        });
  }

    // void getPermission() async{
    //   print("Get Permission");
    //   await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    // }


Future<String> downloadFile(String url, String fileName, String dir) async {
        HttpClient httpClient = new HttpClient();
        File file;
        String filePath = '';
        String myUrl = '';
        print(fileName);
    
        try {
          myUrl = url+'/'+fileName;
          var request = await httpClient.getUrl(Uri.parse(myUrl));
          var response = await request.close();
          if(response.statusCode == 200) {
            var bytes = await consolidateHttpClientResponseBytes(response);
            filePath = '$dir/$fileName';
            file = File(filePath);
            await file.writeAsBytes(bytes);
            print("Done");
          }
          else
            filePath = 'Error code: '+response.statusCode.toString();
        }
        catch(ex){
          filePath = 'Can not fetch url';
        }
    
        return filePath;
      }
      
Future download2(Dio dio, String url, String savePath) async {
    //get pdf from link
    print("hello2");
    Response response = await dio.get(
      url,
      // onReceiveProgress: showDownloadProgress,
      //Received data with List<int>
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );

    //write in download folder
    File file = File(savePath);
    print("Check 0");
    // await file.writeAsBytes(response.bodyBytes);
    var raf = file.openSync(mode: FileMode.write);
    print("Check1");
    raf.writeFromSync(response.data);
    print("Check2");
    await raf.close();
  }
//progress bar
  // if (total != -1) {
  // print((received / total * 100).toStringAsFixed(0) + "%");
  // }
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
