import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.075,
      width: double.infinity,
      // color: Colors.red,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            height: height * 0.055,
            width: width * 0.110,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            child: const Center(
              child: Icon(
                Icons.home,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Yash's Business",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Tap to Switch Business",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            height: height * 0.075,
            width: width * 0.060,
            // color: Colors.red,
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: width * 0.270,
          ),
          const Icon(
            Icons.person,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
