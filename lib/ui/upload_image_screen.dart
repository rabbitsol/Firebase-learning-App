import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebaselearningapp/ui/utils/utils.dart';
import 'package:firebaselearningapp/widgets/round_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebsse_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  firebsse_storage.FirebaseStorage storage =
      firebsse_storage.FirebaseStorage.instance;

  DatabaseReference databaseReference = FirebaseDatabase.instance.ref('Post');

  bool loading = false;
  File? image;
  final picker = ImagePicker();
  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        Utils().toastmessage('No Image Picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Image'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                    height: 200,
                    width: 200,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: image != null
                        ? Image.file(image!.absolute)
                        : const Icon(Icons.image)),
              ),
              const SizedBox(height: 40),
              RoundButtonWidget(
                  title: 'Upload',
                  loading: loading,
                  onpres: () async {
                    setState(() {
                      loading = true;
                    });
                    firebsse_storage.Reference ref =
                        firebsse_storage.FirebaseStorage.instance.ref(
                            '/foldername/${DateTime.now().microsecondsSinceEpoch}');
                    firebsse_storage.UploadTask uploadTask =
                        ref.putFile(image!.absolute);
                    await Future.value(uploadTask);
                    var newUrl = await ref.getDownloadURL();

                    databaseReference
                        .child('1')
                        .set({'id': '1212', 'title': newUrl.toString()}).then(
                            (value) {
                      setState(() {
                        loading = false;
                      });
                      Utils()
                          .toastmessage('Image Uploaded to Firebase Database');
                    }).onError((error, stackTrace) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastmessage(error.toString());
                    });
                    //  Minne Funtion of Future.value is not giving any error so it is all correct.
                    // But the Future.value of Asif Taj is giving error thats why i am copying that code
                    // too for future reference in case of any error
                    // Future.value(uploadTask).then((value) {
                    //   var newUrl = ref.getDownloadURL();

                    //   databaseReference
                    //       .child('1')
                    //       .set({'id': '1212', 'title': newUrl.toString()}).then(
                    //           (value) {
                    //     setState(() {
                    //       loading = false;
                    //     });
                    //     Utils().toastmessage(
                    //         'Image Uploaded to Firebase Database');
                    //   }).onError((error, stackTrace) {
                    //     setState(() {
                    //       loading = false;
                    //     });
                    //     Utils().toastmessage(error.toString());
                    //   });
                    // }).onError((error, stackTrace) {

                    //   Utils().toastmessage(error.toString());
                    // setState(() {
                    //   loading = false;
                    // });
                    // });
                  })
            ]),
      ),
    );
  }
}

// Here below is the chatGPT written code 

// import 'dart:io';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebaselearningapp/ui/utils/utils.dart';
// import 'package:firebaselearningapp/widgets/round_button_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// class UploadImageScreen extends StatefulWidget {
//   const UploadImageScreen({Key? key});

//   @override
//   State<UploadImageScreen> createState() => _UploadImageScreenState();
// }

// class _UploadImageScreenState extends State<UploadImageScreen> {
//   firebase_storage.FirebaseStorage storage =
//       firebase_storage.FirebaseStorage.instance;

//   DatabaseReference databaseReference =
//       FirebaseDatabase.instance.reference().child('Post');

//   bool loading = false;
//   File? image;
//   final picker = ImagePicker();

//   Future getImageGallery() async {
//     final pickedFile = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 100,
//     );

//     setState(() {
//       if (pickedFile != null) {
//         image = File(pickedFile.path);
//       } else {
//         Utils().toastmessage('No Image Picked');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Upload Image'), centerTitle: true),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             InkWell(
//               onTap: getImageGallery,
//               child: Container(
//                 height: 200,
//                 width: 200,
//                 decoration:
//                     BoxDecoration(border: Border.all(color: Colors.black)),
//                 child: image != null
//                     ? Image.file(image!)
//                     : const Icon(Icons.image),
//               ),
//             ),
//             const SizedBox(height: 40),
//             RoundButtonWidget(
//               title: 'Upload',
//               loading: loading,
//               onpres: () async {
//                 if (image == null) {
//                   Utils().toastmessage('Please select an image');
//                   return;
//                 }

//                 setState(() {
//                   loading = true;
//                 });

//                 final folderName =
//                     DateTime.now().microsecondsSinceEpoch.toString();
//                 final ref = firebase_storage.FirebaseStorage.instance
//                     .ref('/$folderName');
//                 final uploadTask = ref.putFile(image!);

//                 await uploadTask.whenComplete(() {});

//                 final downloadURL = await ref.getDownloadURL();

//                 final postData = {
//                   'id': '1212',
//                   'title': downloadURL.toString()
//                 };

//                 databaseReference.child('1').set(postData).then((_) {
//                   setState(() {
//                     loading = false;
//                   });
//                   Utils().toastmessage('Image Uploaded to Firebase Database');
//                 }).catchError((error) {
//                   setState(() {
//                     loading = false;
//                   });
//                   Utils().toastmessage(error.toString());
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
