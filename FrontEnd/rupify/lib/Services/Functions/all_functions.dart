import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../all_api.dart';
import 'package:http/http.dart' as http;
import '../user_model.dart';

class Functions{
  Future<void> fetchData(BuildContext context,UserModelPrimary user) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      final response = await http.post(
        Uri.parse(rupifyAPI),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"aadhar": user.aadharNumber}),
      );
      final responseData = jsonDecode(response.body);
      List<dynamic> notes = responseData['notes'];
      for (dynamic note in notes) {
        String realNote = note.split("::")[0];
        final response2 = await http.post(
          Uri.parse(getValAPI),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"note": realNote}),
        );
        int responseData = int.parse(response2.body);
        user.noteData[note] = responseData;
        user.history[note] = responseData;
      }

      final responsePendingNotes = await http.post(
        Uri.parse('$pendingNoteAPI?aadhar=${user.aadharNumber}'),
        headers: {"Content-Type": "application/json"},
      );
      List<String> list = responsePendingNotes.body
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('"', '')
          .split(',')
          .map((element) => element.trim())
          .where((element) => element.isNotEmpty)
          .toList();
      for (dynamic note in list) {
        final response2 = await http.post(
          Uri.parse(getValAPI),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"note": note}),
        );
        int responseData = int.parse(response2.body);
        user.history[note] = -1 * responseData;
        user.noteData.removeWhere((data, index) {
          List<String> parts = data.split("::");
          return parts.length > 1 && parts[0] == note;
        });
      }
      updateEverything(user);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not connected to the internet.'),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }
  void updateEverything(UserModelPrimary user)  {
    int sum = user.noteData.values
        .fold(0, (previousValue, element) => previousValue + element);
    user.availableBalance = sum;
  }

  Functions();
}