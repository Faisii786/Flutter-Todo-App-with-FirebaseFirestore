import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/firestore/fetch_delete_update.dart';
import 'package:todo_app/screens/post_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "My Tasks",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: FetchData(),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                Get.to(() => const PostScreen());
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 2, 15, 88),
                ),
                child: const Center(
                  child: Text(
                    "Add New Post",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
