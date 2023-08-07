class User{
  String aadharNumber;
  String userName;
  String userPic;
  String phoneNumber;
  String availableBalance;
  Map<String, int> history;
  Map<String, int> noteData;
  Map<String,dynamic> userData;
  User({required this.aadharNumber,required this.userName,required this.userPic, required this.phoneNumber, required this.availableBalance,required this.noteData, required this.history,required this.userData});
}