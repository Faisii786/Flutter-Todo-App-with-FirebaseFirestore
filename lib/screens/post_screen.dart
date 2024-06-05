import 'package:flutter/material.dart';
import 'package:todo_app/firestore/add_post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Post Screen",
        ),
      ),
      body: const AddPost(),
    );
  }
}
