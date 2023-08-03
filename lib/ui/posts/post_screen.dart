import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebaselearningapp/ui/posts/add_post.dart';
import 'package:firebaselearningapp/ui/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  String searchFilter = '';
  final editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Post Screen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Search', border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {
                  searchFilter = value;
                });
              },
            ),
          ),
          // Expanded(
          //     child: StreamBuilder(
          //         stream: ref.onValue,
          //         builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //           if (!snapshot.hasData) {
          //             return const CircularProgressIndicator();
          //           } else {
          //             Map map = snapshot.data!.snapshot.value as dynamic;
          //             List<dynamic> list = [];
          //             list.clear();
          //             list = map.values.toList();
          //             return ListView.builder(
          //                 itemCount: snapshot.data!.snapshot.children.length,
          //                 itemBuilder: (context, index) {
          //                   return ListTile(
          //                     title: Text(list[index]['title']),
          //                     subtitle: Text(list[index]['id']),
          //                   );
          //                 });
          //           }
          //         })),
          Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: const Text('Loading'),
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = snapshot.child('title').value.toString();
                    if (searchFilter.isEmpty) {
                      return ListTile(
                          title: Text(snapshot.child('title').value.toString()),
                          subtitle: Text(snapshot.child('id').value.toString()),
                          trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title);
                                    Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.amber,
                                    );
                                  },
                                  child: const ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit'),
                                  )),
                              PopupMenuItem(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title);
                                  },
                                  value: 2,
                                  child: const ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('Delete'),
                                  )),
                            ],
                          ));
                    } else if (title
                        .toLowerCase()
                        .contains(searchFilter.toLowerCase())) {
                      return ListTile(
                          title: Text(snapshot.child('title').value.toString()),
                          subtitle: Text(snapshot.child('id').value.toString()),
                          trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title);
                                  },
                                  child: const ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit'),
                                  )),
                              PopupMenuItem(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title);
                                  },
                                  value: 2,
                                  child: const ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('Delete'),
                                  )),
                            ],
                          ));
                    } else {
                      return Container();
                    }
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddPostScreen()));
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
                  ref.update({
                    'title': editingController.text.toLowerCase()
                  }).then((value) {
                    Utils().toastmessage('Post Updated');
                  }).onError((error, stackTrace) {
                    Utils().toastmessage(error.toString());
                  });
                },
                child: const Text('Update'))
          ],
        );
      },
    );
  }
}
