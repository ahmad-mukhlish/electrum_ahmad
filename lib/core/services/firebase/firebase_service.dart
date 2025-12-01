import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_service.g.dart';

/// Provider for Firebase Auth instance
@riverpod
firebase_auth.FirebaseAuth firebaseAuth(Ref ref) =>
    firebase_auth.FirebaseAuth.instance;

/// Provider for Firestore instance
//TODO @ahmad-mukhlis consider to move this into separate file
@riverpod
FirebaseFirestore firestore(Ref ref) => FirebaseFirestore.instance;
