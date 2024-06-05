import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FetchData extends StatelessWidget {
  const FetchData({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text('Loading....');
            default:
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var post = snapshot.data!.docs[index];
                  TextEditingController updateController =
                      TextEditingController(text: post['post']);

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 2, 15, 88),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  post['post'],
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Update Post'),
                                            content: TextField(
                                              controller: updateController,
                                              maxLines: 6,
                                              decoration: const InputDecoration(
                                                labelText: "Update your post",
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Update'),
                                                onPressed: () async {
                                                  try {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Posts')
                                                        .doc(post.id)
                                                        .update({
                                                      'post':
                                                          updateController.text,
                                                    });
                                                    Navigator.of(context).pop();
                                                  } catch (e) {
                                                    Get.snackbar('Error 404',
                                                        'An error occurred ${e.toString()}');
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      Icons.update,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  InkWell(
                                    onTap: () async {
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection('Posts')
                                            .doc(post.id)
                                            .delete();
                                      } catch (e) {
                                        Get.snackbar('Error 404',
                                            'An error occurred ${e.toString()}');
                                      }
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
          }
        } else {
          return const Center(
            child: Text("No Post yet"),
          );
        }
      },
    );
  }
}
