import 'package:cashbook_with_sqflite/database/dbhelper.dart';
import 'package:cashbook_with_sqflite/model/transaction_model.dart';
import 'package:cashbook_with_sqflite/pages/add_user_page.dart';
import 'package:cashbook_with_sqflite/pages/transaction_page.dart';
import 'package:cashbook_with_sqflite/widget/custom_tab_bar.dart';
import 'package:cashbook_with_sqflite/widget/home_custom_appbar.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBhelper? dBHelper;
  List<dynamic> userList = [];
  String? usernameList;

  getUserData() async {
    userList = await DBhelper().getTotalBalanceOfUser();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const CustomTabBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          shape: const CircleBorder(side: BorderSide.none, eccentricity: 0.5),
          onPressed: () async {
            usernameList = await Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const AddUserPage();
              },
            ));
            if (usernameList != null) {
              await DBhelper()
                  .insertHistoryData(UserModel(username: usernameList!));
              userList = await DBhelper().getTotalBalanceOfUser();
              setState(() {});
            }
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            const CustomAppBar(),
            const Divider(
              color: Colors.grey,
              height: 1,
              thickness: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Your Books",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: width * 0.530,
                ),
                const Icon(
                  size: 32,
                  Icons.menu,
                  color: Colors.blue,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Icon(
                  size: 32,
                  Icons.search,
                  color: Colors.blue,
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                var userName = userList[index]["username"];
                var userBalance = userList[index]["totalAmount"];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return TransactionPage(
                            title: userName,
                            index: index,
                          );
                        },
                      ));
                      userList = await DBhelper().getTotalBalanceOfUser();

                      if (mounted) {
                        super.setState(() {});
                      }
                    },
                    child: Container(
                      height: height * 0.090,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.2)))),
                      child: Row(
                        children: [
                          Container(
                            height: height * 0.050,
                            width: width * 0.100,
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(
                              Icons.book,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.030,
                                    width: width * 0.490,
                                    child: Text(
                                      userName,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    height: height * 0.030,
                                    width: width * 0.230,
                                    // color: Colors.red,
                                    child: Text(
                                      "${userBalance ?? 0} ",
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.more_vert,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: height * 0.030,
                                width: width * 0.750,
                                // color: Colors.blue,
                                child: Text(
                                  DateFormat("d MMMM yyyy")
                                      .format(DateTime.now()),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
