import 'package:flutter/material.dart';
import 'package:rupify/Services/contact.dart';

class Person extends StatefulWidget {
   const Person({Key? key,required this.person}) : super(key: key);
   final People person;

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF172A48),
        title: Text(
          widget.person.name,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.person.transactions.length ,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 200,
            width: 200,
            alignment: (widget.person.transactions[index].sent)?Alignment.centerRight:Alignment.centerLeft,
            child: const  Card(
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
