import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_projectnote/services/AuthService.dart';

class ItemService {
  AuthService _service = AuthService();

  Future<bool> addItem2Firebase(String documentid, Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection(_service.user!.email.toString())
        .doc(documentid)
        .set(data)
        .then((value) {
      print("Item created");
      return true;
    }).catchError((error) {
      print("Can't create item:" + error.toString());
    });
  }

  Future<bool> editItem(String documentid, Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection(_service.user!.email.toString())
        .doc(documentid)
        .update(data)
        .then((value) {
      print("Item update");
      return true;
    }).catchError((error) {
      print("Can't update item:" + error.toString());
    });
  }

  Future<bool> deleteItem(String documentid) {
    return FirebaseFirestore.instance
        .collection(_service.user!.email.toString())
        .doc(documentid)
        .delete()
        .then((value) {
      print("Item deleted");
      return true;
    }).catchError((error) {
      print("Can't delete item:" + error.toString());
    });
  }
}
