class UserModelPrimary {
  String? aadharNumber;
  String? userName;
  String? userPic;
  String? phoneNumber;
  List<int>? purpose;
  List<String>? noteData;
  UserModelPrimary(
      {required this.aadharNumber,
      required this.userName,
      required this.userPic,
      required this.phoneNumber,
      required this.noteData,
      required this.purpose
      });


  UserModelPrimary.fromMap(Map<dynamic, dynamic> user) {
    aadharNumber = user['aadhar_number'];
    userName = user['first_name']+' ' +user['last_name'];
    userPic = user['user_Picture'];
    phoneNumber = user['phone'];
    noteData = user['noteData'];
    purpose = user['purpose'];
  }
}
