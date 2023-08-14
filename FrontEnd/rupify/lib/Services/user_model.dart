class UserModelPrimary{
  String aadharNumber;
  // 1234********
  String userName;
  String userPic;
  String phoneNumber;
  int availableBalance;
  Map<String, int> history;
  Map<String, int> noteData;
  Map<String,dynamic> userData;
  UserModelPrimary({required this.aadharNumber,required this.userName,required this.userPic, required this.phoneNumber, required this.availableBalance,required this.noteData, required this.history,required this.userData});
}