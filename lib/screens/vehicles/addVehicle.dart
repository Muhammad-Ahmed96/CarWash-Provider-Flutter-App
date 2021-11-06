// import 'dart:async';
// import 'dart:convert';
// // import 'dart:html';
// // import 'dart:js';

// import 'package:animation_wrappers/animation_wrappers.dart';
// import 'package:carwash_provider/assets/assets.dart';
// import 'package:carwash_provider/components/widgets.dart';
// import 'package:carwash_provider/language/locale.dart';
// import 'package:carwash_provider/screens/home.dart';
// import 'package:carwash_provider/screens/packages/addPackage.dart';
// import 'package:carwash_provider/screens/packages/packageItem.dart';
// import 'package:carwash_provider/screens/packages/packages.dart';
// import 'package:carwash_provider/style/colors.dart';
// import 'package:carwash_provider/user_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart';

// class AddVehicle extends StatefulWidget {
//   const AddVehicle({Key? key}) : super(key: key);

//   @override
//   _AddVehicle createState() {
//     return _AddVehicle();
//   }
// }

// class _AddVehicle extends State<AddVehicle> {

//   String state = 
//   // final _formKey = GlobalKey<FormState>();
//   // Timer? _timer;
//   final titleController = TextEditingController();

//   final bool _titleValidate = false;
//   final bool _durationValidate = false;
//   final bool _priceValidate = false;
//   final bool _descriptionValidate = false;

//   String? _image; //variable for choosed file
//   String status = '';
//   ImagePicker picker = ImagePicker();

//   // Future<String> uploadImage(filename, url) async {
//   //   var request = http.MultipartRequest('POST', Uri.parse(url));
//   //   request.files.add(await http.MultipartFile.fromPath('picture', filename));
//   //   var res = await request.send();
//   //   return res.reasonPhrase;
//   // }

//   // _AddVehicle() {
//   //   configLoading();
//   // }

//   // Future getImage() async {
//   //   XFile? image = await picker.pickImage(source: ImageSource.gallery);
//   //   if (image != null) {
//   //     List<int>? imageBytes = await image.readAsBytes();
//   //     String base64Image = base64Encode(imageBytes);
//   //     setState(() {
//   //       this._image = base64Image;
//   //     });
//   //   }

//   // getImage() async {
//   //   var file = await ImagePicker().pickImage(source: ImageSource.gallery);
//   //    var res = await uploadImage(file.path, "////");
//   // }

//     // final pickedFile = await picker.getImage(
//     //     source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
//     // List<int> imageBytes = await pickedFile.readAsBytes();
//     // String base64Image = base64Encode(imageBytes);

//     // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//   }

//   // @override
//   // void initState() {
//   //   EasyLoading.addStatusCallback((status) {
//   //     print('EasyLoading Status $status');
//   //     if (status == EasyLoadingStatus.dismiss) {
//   //       _timer?.cancel();
//   //     }
//   //   });
//   // }

//   void configLoading() {
//     EasyLoading.instance
//       ..displayDuration = const Duration(milliseconds: 2000)
//       ..indicatorType = EasyLoadingIndicatorType.fadingCircle
//       ..loadingStyle = EasyLoadingStyle.dark
//       ..indicatorSize = 45.0
//       ..radius = 10.0
//       ..progressColor = Colors.yellow
//       ..backgroundColor = Colors.green
//       ..indicatorColor = Colors.yellow
//       ..textColor = Colors.yellow
//       ..maskColor = Colors.blue.withOpacity(0.5)
//       ..userInteractions = true
//       ..dismissOnTap = false;
//     // ..customAnimation = CustomAnimation();
//   }

//   // Future<void> addVehicle(title, image) async {
//   //   // https://carwash-back.herokuapp.com/company/v1/packages
//   //   final prefs = await SharedPreferences.getInstance();
//   //   var companyId = prefs.getInt("token");
//   //   var url = Uri.parse('http://10.10.10.34:3000/company/v1/vehicle_types');
//   //   var response = await http.post(url,
//   //       headers: <String, String>{
//   //         'Content-Type': 'application/json; charset=UTF-8',
//   //       },
//   //       body: json
//   //           .encode({'title': title, 'company_id': companyId, 'image': image}));
//   //   // print("response");
//   //   // print(response.body);
//   //   if (response.statusCode == 200) {
//   //     EasyLoading.dismiss();
//   //     Navigator.push(
//   //         context, MaterialPageRoute(builder: (context) => Packages()));
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //         content: Text("Error Adding Package..."),
//   //         backgroundColor: Colors.red));
//   //     EasyLoading.dismiss();
//   //   }
//   // }

//   // bool validate() {
//   //   bool flag = false;
//   //   var msg = "";
//   //   if (titleController.text == "") {
//   //     msg += "Title cannot be blank";
//   //     flag = true;
//   //   }

//   //   if (flag) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text(msg), backgroundColor: Colors.red));
//   //   }

//   //   return flag;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Text("Add Vehicle"),
//           centerTitle: true,
//           // actions: [
//           //   Padding(
//           //       padding:
//           //           const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           //       child: GestureDetector(
//           //         onTap: () {
//           //           Navigator.push(context,
//           //               MaterialPageRoute(builder: (context) => AddVehicle()));
//           //         },
//           //         child: Text(
//           //           "Add New",
//           //           style: TextStyle(color: Colors.grey),
//           //           // color: Colors.grey,
//           //           // size: 20,
//           //         ),
//           //       ))
//           // ],
//         ),
//         body: FadedSlideAnimation(
//           Stack(
//             // alignment: Alignment.bottomCenter,
//             children: [
//               Container(
//                 foregroundDecoration: BoxDecoration(
//                     gradient: LinearGradient(colors: [
//                   Colors.transparent,
//                   Theme.of(context).backgroundColor
//                 ], begin: Alignment.topCenter)),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(Assets.splashBg),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SingleChildScrollView(
//                 child: Container(
//                   height: MediaQuery.of(context).size.height,
//                   // margin: EdgeInsets.only(top: deviceHeight * 0.18),
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       // Spacer(flex: 3),

//                       // // Row(
//                       // //   children: [
//                       // Container(
//                       //   color: Colors.transparent,
//                       //   height: deviceHeight * 0.12,
//                       //   child: Image(image: AssetImage(Assets.logo)),
//                       // ),
//                       SizedBox(
//                         height: 60,
//                       ),
//                       Column(
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               EntryField("Title", "Enter Title", false,
//                                   "", ""),
//                               // Visibility(
//                               //   child: Text('Title cannot be empty'),
//                               //   visible: true,
//                               // ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Column(
//                             // crossAxisAlignment: CrossAxisAlignment.center,
//                             // mainAxisSize: MainAxisSize.max,
//                             // mainAxisAlignment: MainAxisAlignment.end,
//                             children: <Widget>[
//                               Container(
//                                 child: TextButton(
//                                   child: Text('Select Image'),
//                                   style: TextButton.styleFrom(
//                                     primary: Colors.white,
//                                     backgroundColor: Colors.teal,
//                                     onSurface: Colors.grey,
//                                   ),
//                                   onPressed: () {
//                                     getImage();
//                                     // file = ImagePicker.pickImage(source: ImageSource.gallery)
//                                   },
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               // EasyLoading.show(status: 'loading...');
//                               if (!validate()) {
//                                 addVehicle(titleController.text, this._image);
//                               }
//                             },
//                             child: GradientButton("Submit"),
//                           ),
//                           SizedBox(
//                             height: 60,
//                           ),
//                         ],
//                       ),
//                       Spacer()
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           beginOffset: Offset(0, 0.3),
//           endOffset: Offset(0, 0),
//           slideCurve: Curves.linearToEaseOut,
//         ));
//   }
// }
