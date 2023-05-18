class UsersModel{
  int? userID;
  String? userName;
  String? password;
  String? email;

  UsersModel({this.userID,this.userName,this.password,this.email});

  UsersModel.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    userName = json['UserName'];
    password = json['Password'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = this.userID;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['Email'] = this.email;
    return data;
  }
}