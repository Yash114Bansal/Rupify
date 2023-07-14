import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  final Map<String, int> Note_Data;
  NotesScreen({required this.Note_Data}){}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Available',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: Note_Data.length,
        itemBuilder: (BuildContext context, int index) {
          String key = Note_Data.keys.elementAt(index);
          int value = Note_Data.values.elementAt(index);
          String imagePath = '';

          switch (value) {
            case 10:
              imagePath = 'assets/Rupees/rs10.jpg';
              break;
            case 20:
              imagePath = 'assets/Rupees/rs20.jpg';
              break;
            case 50:
              imagePath = 'assets/Rupees/rs50.jpg';
              break;
            case 100:
              imagePath = 'assets/Rupees/rs100.jpg';
              break;
            case 200:
              imagePath = 'assets/Rupees/rs200.jpg';
              break;
            case 500:
              imagePath = 'assets/Rupees/rs500.jpg';
              break;
            case 1000:
              imagePath = 'assets/Rupees/rs1000.jpg';
              break;
            case 2000:
              imagePath = 'assets/Rupees/rs2000.jpg';
              break;
          }

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
            ),
          );
        },
      ),
    );
  }
}
