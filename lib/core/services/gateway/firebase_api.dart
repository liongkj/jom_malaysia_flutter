import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final Firestore _db = Firestore.instance;
  String path;
  CollectionReference ref;

  FirebaseService() {
    ref = _db.collection("places");
    print("created");
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection(
      String collectionName, String listingId) {
    return ref.document(listingId).collection(collectionName).snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }
}
