import 'package:flutter/material.dart';

class CustomFloatButtonTransPage extends StatelessWidget {
  const CustomFloatButtonTransPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FloatingActionButton(
      shape: const CircleBorder(
          side: BorderSide(
            color: Colors.white,
          )),
      backgroundColor: Colors.white,
      child: Container(
        height: height * 0.060,
        width: width * 0.120,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 0, 81, 147), Colors.blue]),
            borderRadius: BorderRadius.circular(100)),
        child: const Icon(
          size: 30,
          Icons.mic,
          color: Colors.white,
        ),
      ),
      onPressed: () {},
    );
  }
}
