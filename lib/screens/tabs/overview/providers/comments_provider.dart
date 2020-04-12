import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/gateway/firestore_api.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/setting/provider/base_change_notifier.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class CommentsProvider extends BaseChangeNotifier {
  FirestoreService _api;

  CommentsProvider({@required FirestoreService firebaseService})
      : _api = firebaseService;
  String _documentId;
  List<CommentModel> comments;
  final String collectionName = "comments";

  String getCommentId() {
    if (_documentId == null) _documentId = _api.getDocumentId();
    return _documentId;
  }

  Future<void> addComment(String listingId, CommentModel data) async {
    await _api.addDocument(listingId, collectionName, data.toJson());
    setStateType(StateType.empty); //end loading
  }

  ///if [getAll] is false, return 5 comments, used in home page
  Stream<QuerySnapshot> fetchCommentsAsStream(String listingId,
      {bool getAll = false}) {
    if (getAll) return _api.streamDataCollection(collectionName, listingId);
    return _api.streamLatest3Collection(collectionName, listingId);
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

//  Future<List<CommentModel>> fetchComments() async {
//    var result = await _api.getDataCollection();
//    comments = result.documents
//        .map((doc) => CommentModel.fromMap(doc.data, doc.documentID))
//        .toList();
//    return comments;
//  }
}
