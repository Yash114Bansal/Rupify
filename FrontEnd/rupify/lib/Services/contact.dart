import 'package:rupify/Services/transaction.dart';

class People{
  String name;
  String profilePic;
  List<int> purposes;
  String mobileNumber;
  List<Transaction> transactions;
  People({ required this.name, required this.profilePic, required this.mobileNumber, required this.purposes,required this.transactions });
}