import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_projectnote/screens/login_screen.dart';
import 'package:flutter_firebase_projectnote/services/AuthService.dart';
import 'const/burger.dart';
import 'firebase_options.dart';

import 'package:flutter_firebase_projectnote/screens/edititem.dart';
import 'package:flutter_firebase_projectnote/screens/additem.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final service = AuthService();
    User? currentuser = service.user;
    String displayEmail = "";
    String displayName = "";
    if (currentuser != null && currentuser.email != null) {
      displayEmail = currentuser.email!;
    }
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder: ((context, snapshot) {
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null) return const Text("No data");
          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataDocuments[index]["title"].toString()),
                subtitle: Text(dataDocuments[index]["time"].toString()),
                onTap: () => _editItemScreen(
                    dataDocuments[index].id,
                    dataDocuments[index]["title"],
                    dataDocuments[index]["time"],
                    dataDocuments[index]["desc"]),
              );
            },
          );
        }),
      ),
      drawer: Burger(
        displayEmail: displayEmail,
      ),
      appBar: AppBar(
        title: Text("YourNote"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewItem,
        tooltip: 'Create New Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNewItem() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Additem()));
  }

  _editItemScreen(
    String documentid,
    String itemName,
    String itemDesc,
    String time,
  ) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditItemScreen(
                  documentid,
                  itemName,
                  time,
                  itemDesc,
                )));
  }
}

Widget WelCome({required String displayEmail}) {
  return Scaffold(
      drawer: Burger(
        displayEmail: displayEmail,
      ),
      appBar: AppBar(
        title: Text("YourNote"),
      ));
}
