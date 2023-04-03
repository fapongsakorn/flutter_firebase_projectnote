import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_projectnote/main.dart';
import '../services/item_services.dart';

class Additem extends StatefulWidget {
  @override
  State<Additem> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<Additem> {
  final itemName = TextEditingController();
  final itemDesc = TextEditingController();
  final ItemService _itemService = ItemService();
  late String _timeString;
  void initState() {
    _timeString =
        "DAY ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  TIME : ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.initState();
  }

  void _getCurrentTime() {
    setState(() {
      _timeString =
          "DAY ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  TIME : ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(_timeString),
            TextField(
              controller: itemName,
              decoration: InputDecoration(label: Text("Title")),
            ),
            TextField(
              controller: itemDesc,
              decoration: InputDecoration(label: Text("Description")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _addItem, child: const Text("Save"))
          ],
        ),
      ),
    );
  }

  _addItem() {
    if (itemName.text.isNotEmpty || itemDesc.text.isNotEmpty) {
      _itemService.addItem2Firebase(itemName.text,
          {"time": _timeString, "title": itemName.text, "desc": itemDesc.text});
      if (true) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Note is Empty"),
        ),
      );
      return Container();
    }
  }
}
