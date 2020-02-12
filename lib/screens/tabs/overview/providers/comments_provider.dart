import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/gateway/firebase_api.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';

class CommentsProvider extends ChangeNotifier {
  FirebaseApi _api;
  CommentsProvider(FirebaseApi apiService) : _api = apiService;

  List<CommentModel> products;

  Future<List<CommentModel>> fetchProducts() async {
    var result = await _api.getDataCollection();
    products = result.documents
        .map((doc) => CommentModel.fromMap(doc.data, doc.documentID))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<CommentModel> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return CommentModel.fromMap(doc.data, doc.documentID);
  }

  Future removeProduct(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateProduct(CommentModel data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addProduct(CommentModel data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
