class UserModel {
  String username;

  int? finalAmount;
  int? cashInAmount;
  int? cashOutAmount;
  String? date;
  String? time;

  UserModel(
      {this.finalAmount,
      required this.username,
      this.cashInAmount,
      this.time,
      this.date,
      this.cashOutAmount});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        username: map["username"],
        finalAmount: map["finalAmount"],
        cashInAmount: map["cashInAmount"],
        time: map["time"],
        date: map["date"],
        cashOutAmount: map["cashOutAmount"]);
  }

  Map<String, Object?> toJson() {
    return {
      "username": username,
      "finalAmount": finalAmount,
      "cashInAmount": cashInAmount,
      "cashOutAmount": cashOutAmount,
      "time": time,
      "date": date
    };
  }
}
