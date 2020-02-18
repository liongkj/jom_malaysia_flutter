import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/gateway/firestore_api.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';

class CommentsProvider extends ChangeNotifier {
  FirestoreService _api;
  CommentsProvider({@required FirestoreService firebaseService})
      : _api = firebaseService;
  String _documentId;
  List<CommentModel> comments;

  String getCommentId() {
    if (_documentId == null) _documentId = _api.getDocumentId();
    return _documentId;
  }

  Future addComment(String listingId, CommentModel data) async {
    var result = await _api.addDocument(listingId, "comments", data.toJson());

    return;
  }

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
}
