import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearningapp/ui/firestore/add_firestore_data_screen.dart';
import 'package:firebaselearningapp/ui/utils/utils.dart';
import 'package:flutter/material.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final auth = FirebaseAuth.instance;
  String searchFilter = '';
  final editingController = TextEditingController();
  // final fireStore = FirebaseFirestore.instance.collection('user').snapshots();
  final ref = FirebaseFirestore.instance.collection('user');
  // final CollectionReference<Map<String, dynamic>> ref =
  //     FirebaseFirestore.instance.collection('user');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Firestore Screen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
              stream: ref.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              onTap: () {
                                ref
                                    .doc(snapshot.data!.docs[index]['id']
                                        .toString())
                                    .update({
                                  'title': 'Firestore Tutorial'
                                }).then((value) {
                                  Utils().toastmessage('Updated');
                                }).onError((error, stackTrace) {
                                  Utils().toastmessage(error.toString());
                                });
                                ref
                                    .doc(snapshot.data!.docs[index]['id']
                                        .toString())
                                    .delete();
                              },
                              title: Text(snapshot.data!.docs[index]['title']
                                  .toString()),
                              subtitle: Text(
                                  snapshot.data!.docs[index]['id'].toString()));
                        }));
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddFirestoreDataScreen()));
          },
          child: const Icon(Icons.add)),
    );
  }

  Future<void> showMyDialog(String title) async {
    editingController.text = title;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update'),
          content: TextField(
            controller: editingController,
            decoration: const InputDecoration(hintText: 'Edit'),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Update'))
          ],
        );
      },
    );
  }
}
