import 'package:cashbook_with_sqflite/widget/home_custom_appbar.dart';

import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    TextEditingController usernameController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        bottomSheet: SizedBox(
          height: height * 0.090,
          width: double.infinity,
          // color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context, usernameController.text);
                },
                child: Container(
                  height: height * 0.060,
                  width: width * 0.500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 2.0)),
                  child: const Center(
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            const CustomAppBar(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                    labelText: "Add User Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
