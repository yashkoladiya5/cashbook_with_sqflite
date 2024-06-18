import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomScroll extends StatelessWidget {
  const CustomScroll({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              height: height * 0.040,
              width: width * 0.150,
              decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#D3D3D3"), width: 3),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(
                Icons.add_road_rounded,
                color: Colors.blue,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 10),
                height: height * 0.040,
                width: width * 0.380,
                decoration: BoxDecoration(
                    border: Border.all(color: HexColor("#D3D3D3"), width: 3),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 7,
                    ),
                    Icon(
                      size: 20,
                      Icons.calendar_month,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Select Date"),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    )
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(left: 10),
                height: height * 0.040,
                width: width * 0.300,
                decoration: BoxDecoration(
                    border: Border.all(color: HexColor("#D3D3D3"), width: 3),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text("Entry Type"),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    )
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(left: 10),
                height: height * 0.040,
                width: width * 0.300,
                decoration: BoxDecoration(
                    border: Border.all(color: HexColor("#D3D3D3"), width: 3),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text("Memories"),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
