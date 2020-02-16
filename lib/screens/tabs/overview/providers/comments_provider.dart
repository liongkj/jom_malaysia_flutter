import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/gateway/firebase_api.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';

class CommentsProvider extends ChangeNotifier {
  FirebaseService _api;
  CommentsProvider({@required FirebaseService firebaseService})
      : _api = firebaseService;

  List<CommentModel> comments;

  Future<List<CommentModel>> fetchcomments() async {
    var result = await _api.getDataCollection();
    comments = result.documents
        .map((doc) => CommentModel.fromMap(doc.data, doc.documentID))
        .toList();
    return comments;
  }

  Stream<QuerySnapshot> fetchCommentsAsStream(String listingId) {
    return _api.streamDataCollection("comments", listingId);
  }

  Future<CommentModel> getCommentsById(String id) async {
    var doc = await _api.getDocumentById(id);
    return CommentModel.fromMap(doc.data, doc.documentID);
  }

  Future removeComments(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateComments(CommentModel data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addComments(CommentModel data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
