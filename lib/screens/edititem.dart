import 'package:flutter/material.dart';
import '../main.dart';
import '../services/item_services.dart';

class EditItemScreen extends StatefulWidget {
  late String documentid;
  final _time = TextEditingController();
  final _itemName = TextEditingController();
  final _itemDesc = TextEditingController();
  EditItemScreen(
      String documentid, String itemname, String itemdesc, String time) {
    documentid = documentid;
    _itemName.text = itemname;
    _time.text = time;
    _itemDesc.text = itemdesc;
  }

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final ItemService _itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: widget._time,
              decoration: const InputDecoration(label: Text("Time")),
              readOnly: true,
            ),
            TextField(
              controller: widget._itemName,
              decoration: const InputDecoration(label: Text("Title")),
              readOnly: true,
            ),
            TextField(
              controller: widget._itemDesc,
              decoration: const InputDecoration(label: Text("Description")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _editItem, child: const Text("Update")),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: _deleteItem, child: const Text("Delete")),
            ),
          ],
        ),
      ),
    );
  }

  void _editItem() {
    _itemService.editItem(widget._itemName.text, {
      "time": widget._time.text,
      "title": widget._itemName.text,
      "desc": widget._itemDesc.text
    });
    if (true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Update Sccessful"),
        ),
      );
    }
  }

  void _deleteItem() {
    _itemService.deleteItem(widget._itemName.text);
    if (true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Delete Sccessful"),
        ),
      );
    }
  }
}
