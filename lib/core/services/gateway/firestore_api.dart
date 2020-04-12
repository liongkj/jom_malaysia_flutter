import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final Firestore _db = Firestore.instance;
  String path;
  CollectionReference ref;

  FirestoreService() {
    ref = _db.collection("places");
  }

  String getDocumentId() {
    return ref.document().documentID;
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamLatest3Collection(
      String collectionName, String listingId) {
    return ref
        .document(listingId)
        .collection(collectionName)
        .snapshots()
        .take(3);
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

  Future<DocumentReference> addDocument(
      String listingId, String collectionName, Map data) {
    return ref.document(listingId).collection(collectionName).add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }
}
