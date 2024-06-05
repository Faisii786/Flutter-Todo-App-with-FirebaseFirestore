import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/home_page.dart';
import 'package:todo_app/utills/snackbar.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController postController = TextEditingController();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: postController,
                maxLines: 3,
                maxLength: 50,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  alignLabelWithHint: true,
                  labelText: "What's on your mind....",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          left: 10,
          right: 10,
          child: InkWell(
            onTap: () async {
              try {
                await firestore
                    .collection("Posts")
                    .doc(DateTime.now().microsecondsSinceEpoch.toString())
                    .set({
                  'id': DateTime.now().microsecondsSinceEpoch.toString(),
                  'post': postController.text.toString(),
                }).then((value) => {
                          MySnackBar.showSnackBar(
                              'Post', 'Your post is successfully added'),
                          postController.clear(),
                          Get.to(() => const HomePage()),
                        });
              } catch (e) {
                MySnackBar.showSnackBar(
                    'Error 404', 'An error occured ${e.toString()}');
              }
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 2, 15, 88),
              ),
              child: const Center(
                child: Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
