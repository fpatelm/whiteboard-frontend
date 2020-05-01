import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService() {
    Firestore.instance.settings(persistenceEnabled: false);
  }

  Firestore get() => Firestore.instance;
}
