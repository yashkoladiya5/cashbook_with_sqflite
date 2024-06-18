// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashInPage extends StatefulWidget {
  final String username;
  const CashInPage({super.key, required this.username});

  @override
  State<CashInPage> createState() => _CashInPageState();
}

class _CashInPageState extends State<CashInPage> {
  int amount = 0;
  DateTime _date = DateTime.now();
  DateTime? datePicker;
  String? currentDate;
  String? currentTime;

  String? formatDate;
  String? formatTime;
  late String mergedDateTime;
  selectDate(context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    );
    // ignore: body_might_complete_normally_nullable
    if (datePicker != null) {
      setState(() {
        _date = datePicker;
      });
    }
  }

  TimeOfDay? _timeOfDay = TimeOfDay.now();
  TimeOfDay? timepicker;

  selectTime(context) async {
    timepicker =
        await showTimePicker(context: context, initialTime: TimeOfDay.now())
            .then((value) {
      setState(() {
        _timeOfDay = value;
      });
      return null;
    });
  }

  datePickerConvert() {
    print("formatDate ==== $_date");
    formatDate = _date.toString();
    formatDate = formatDate!.substring(0, 10);
    print("final Date ==== $formatDate");

    // DateTime dateTime = DateTime.parse(formatDate);
    // String date = DateFormat("d MMMM y").format(dateTime);
    // print("Formatted Date ====== $date");
  }

  timePickerConvert() {
    String convertTime = "${_timeOfDay!.hour}:${_timeOfDay!.minute}";
    DateTime time = DateFormat('HH:mm').parse(convertTime);
    formatTime = DateFormat("h:mm a").format(time);
    print("Formatted time ==== $formatTime");
    if (formatTime!.length == 7) {
      formatTime = "0$formatTime";
      print("After Updating === $formatTime");
    }
  }

  currentDateTime() async {
    currentDate = DateTime.now().toString();
    currentDate = currentDate!.substring(0, 10);
    TimeOfDay now = TimeOfDay.now();
    String convertTime = "${now.hour}:${now.minute}";
    DateTime time = DateFormat('HH:mm').parse(convertTime);
    formatTime = DateFormat("h:mm a").format(time);
    print("Formatted time ==== $formatTime");
    if (formatTime!.length == 7) {
      formatTime = "0$formatTime";
      print("After Updating === $formatTime");
    }
    currentTime = formatTime;
    formatTime = null;
    print("Current Date ==== $currentDate");
    print("Current Time ==== $currentTime");
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await currentDateTime();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    TextEditingController amountcontroller = TextEditingController(text: "0");
    return Scaffold(
      bottomSheet: SizedBox(
        height: height * 0.090,
        width: double.infinity,
        // color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (formatTime == null && formatDate == null) {
                    mergedDateTime = "$currentDate$currentTime";
                  } else if (formatTime == null) {
                    mergedDateTime = "$formatDate$currentTime";
                  } else if (formatDate == null) {
                    mergedDateTime = "$currentDate$formatTime";
                  } else {
                    mergedDateTime = "$formatDate$formatTime";
                  }
                  Navigator.pop(
                      context, "$mergedDateTime ${amountcontroller.text}");
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.060,
                  width: width * 0.550,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "SAVE & ADD NEW",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: height * 0.060,
                width: width * 0.350,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "SAVE",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(
            height: 0.4,
            color: Colors.grey,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          "Add Cash In Entry",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        actions: [
          const Icon(
            size: 30,
            Icons.settings,
            color: Colors.blue,
          ),
          SizedBox(
            width: width * 0.050,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    await selectDate(context);
                    await datePickerConvert();
                  },
                  icon: const Icon(
                    size: 25,
                    Icons.calendar_month,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${_date.day}-${_date.month}-${_date.year}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                const Icon(
                  size: 30,
                  Icons.arrow_drop_down_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: width * 0.050,
                ),
                IconButton(
                  onPressed: () async {
                    await selectTime(context);
                    await timePickerConvert();
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  " ${_timeOfDay!.format(context)}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                const Icon(
                  size: 30,
                  Icons.arrow_drop_down_outlined,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 20),
              controller: amountcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Amount *",
                  labelStyle: const TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 5, color: Colors.blue),
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
        ],
      ),
    );
  }
}
