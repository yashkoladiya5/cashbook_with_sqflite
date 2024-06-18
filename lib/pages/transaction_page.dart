import 'package:cashbook_with_sqflite/database/dbhelper.dart';
import 'package:cashbook_with_sqflite/model/transaction_model.dart';
import 'package:cashbook_with_sqflite/pages/cash_in_page.dart';
import 'package:cashbook_with_sqflite/pages/cash_out_page.dart';
import 'package:cashbook_with_sqflite/widget/custom_float_button_trans_page.dart';
import 'package:cashbook_with_sqflite/widget/custom_scrollview.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  final String title;
  final int? index;

  const TransactionPage({super.key, required this.title, this.index});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<UserModel> userData = [];
  int cashInAmount = 0;
  int totalCashInAmount = 0;
  int totalCashOutAmount = 0;
  int balance = 0;
  List<int> totalBalanceList = [];
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('d MMMM y').format(DateTime.now());
  int cashOutAmount = 0;
  int total = 0;
  var totalValue = 0;

  String? refresh;

  totalAmount() {
    var totalAmount = cashInAmount - cashOutAmount;
    setState(() {
      total = totalAmount;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getUserHistoryData();
    });

    super.initState();
  }

  getUserHistoryData() async {
    userData = await DBhelper().getHistoryDataByUser(widget.title);
    totalBalanceList = [];
    balance = 0;
    totalCashInAmount = 0;
    totalCashOutAmount = 0;
    for (var cashInAmounts in userData) {
      if (cashInAmounts.cashInAmount != null) {
        var data = (cashInAmounts.cashInAmount);

        totalCashInAmount += (data ?? 0);
        balance = balance + data!;
        totalBalanceList.add(balance);
      } else if (cashInAmounts.cashOutAmount != null) {
        var data = (cashInAmounts.cashOutAmount);

        totalCashOutAmount += (data ?? 0);
        balance = balance - data!;
        totalBalanceList.add(balance);
      }
    }
    print(totalBalanceList);
    total = totalCashInAmount - totalCashOutAmount;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: HexColor("#D3D3D3"),
      bottomNavigationBar: Container(
        height: height * 0.075,
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  refresh = await Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CashInPage(
                        username: widget.title,
                      );
                    },
                  ));

                  if (refresh != "") {
                    String dbDate = refresh!.substring(0, 10);
                    String time = refresh!.substring(11, 18);
                    if (time[0] == "0") {
                      time = time.substring(1, time.length);
                      print("time in main screen === $time");
                    }
                    DateTime dateTime = DateTime.parse(dbDate);
                    String date = DateFormat("d MMMM y").format(dateTime);
                    print("Formatted Date ====== $date");
                    String amount = refresh!.substring(19, refresh!.length);
                    if (total == 0) {
                      cashInAmount = int.parse(amount);
                    } else {
                      cashInAmount += int.parse(amount);
                    }
                    await totalAmount();

                    await DBhelper().insertHistoryData(UserModel(
                        username: widget.title,
                        date: date,
                        time: time,
                        cashInAmount: int.parse(amount),
                        finalAmount: total));

                    await getUserHistoryData();
                    if (mounted) {
                      setState(() {});
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.050,
                  width: width * 0.440,
                  color: Colors.green,
                  child: const Text(
                    "+ CASH IN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  refresh = await Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CashOutPage(
                        username: widget.title,
                      );
                    },
                  ));
                  if (refresh! != "") {
                    String dbDate = refresh!.substring(0, 10);
                    String time = refresh!.substring(11, 18);
                    if (time[0] == "0") {
                      time = time.substring(1, time.length);
                      print("time in main screen === $time");
                    }
                    DateTime dateTime = DateTime.parse(dbDate);
                    String date = DateFormat("d MMMM y").format(dateTime);
                    print("Formatted Date ====== $date");
                    String amount = refresh!.substring(19, refresh!.length);
                    if (total == 0) {
                      cashOutAmount = int.parse(amount);
                    } else {
                      cashOutAmount += int.parse(amount);
                    }
                    await totalAmount();

                    await DBhelper().insertHistoryData(UserModel(
                        username: widget.title,
                        date: date,
                        time: time,
                        cashOutAmount: int.parse(amount),
                        finalAmount: total));

                    await getUserHistoryData();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.050,
                  width: width * 0.440,
                  color: Colors.red,
                  child: const Text(
                    "- CASH OUT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const CustomFloatButtonTransPage(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, "$total");
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Add Member,Book Activity etc",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
        actions: const [
          Icon(
            Icons.person_outline,
            color: Colors.blue,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.picture_as_pdf,
            color: Colors.blue,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.blue,
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.01),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.065,
            width: double.infinity,
            color: Colors.white,
            child: const Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  size: 35,
                  Icons.search,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Search by remark or amount"),
                  ),
                ),
              ],
            ),
          ),
          const CustomScroll(),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20,
            ),
            child: Container(
              height: height * 0.210,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 5),
                    child: Row(
                      children: [
                        const Text(
                          "Net Balance",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          width: width * 0.325,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: height * 0.035,
                          width: width * 0.300,
                          // color: Colors.red,
                          child: (userData.isNotEmpty)
                              ? Text(
                                  "${total}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : const Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    height: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 5),
                    child: Row(
                      children: [
                        const Text(
                          "Total In(+)",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: width * 0.410,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: height * 0.035,
                          width: width * 0.300,
                          // color: Colors.red,
                          child: Text(
                            "$totalCashInAmount",
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10, right: 5),
                    child: Row(
                      children: [
                        const Text(
                          "Total Out(+)",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: width * 0.390,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: height * 0.035,
                          width: width * 0.300,
                          // color: Colors.red,
                          child: Text(
                            "$totalCashOutAmount",
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    height: 0.5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "VIEW REPORTS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Container(
                  height: height * 0.001,
                  width: width * 0.350,
                  color: Colors.grey,
                ),
                Text(
                  "Showing ${userData.length} entries",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: width * 0.001,
                  width: width * 0.300,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              formattedDate,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          // Column(
          //     children: List.generate(data.paymentList.length,
          //         (index) => data.paymentList[index]))
          Expanded(
            child: userData.isNotEmpty
                ? ListView.builder(
                    // reverse: true,
                    itemCount: userData.length,
                    itemBuilder: (context, index) {
                      var userDataItem = userData[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: height * 0.165,
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 10, left: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: height * 0.030,
                                      width: width * 0.140,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Center(
                                        child: Text(
                                          "Cash",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          height: height * 0.030,
                                          width: width * 0.250,
                                          // color: Colors.black,
                                          child: Text(
                                            (userDataItem.cashInAmount != null)
                                                ? userDataItem.cashInAmount
                                                    .toString()
                                                : userDataItem.cashOutAmount
                                                    .toString(),
                                            style: TextStyle(
                                                color:
                                                    userDataItem.cashInAmount !=
                                                            null
                                                        ? Colors.green
                                                        : Colors.red,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            alignment: Alignment.centerRight,
                                            height: height * 0.030,
                                            width: width * 0.50,
                                            // color: Colors.red,
                                            child: Text(
                                              "Balance : ${totalBalanceList[index] ?? 0} ",
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                height: height * 0.045,
                                width: width * 0.570,
                                // color: Colors.red,
                                child: const Text(
                                  "cash entry is done by User",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                                height: 0.5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Entry by you",
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " ${userData[index].date}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("  at ${userData[index].time}")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
