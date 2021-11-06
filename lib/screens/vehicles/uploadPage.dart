// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// class UploadPage extends StatefulWidget {
//   final String url;

//   @override
//   _UploadPageState createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {
//   Future<String> uploadImage(filename, url) async {
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     request.files.add(await http.MultipartFile.fromPath('picture', filename));
//     var res = await request.send();
//     return res.reasonPhrase;
//   }

//   String state = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter File Upload Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[Text(state)],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           var file = await ImagePicker().pickImage(source: ImageSource.gallery);
//           var res = await uploadImage(file.path, widget.url);
//           setState(() {
//             state = res;
//             print(res);
//           });
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
