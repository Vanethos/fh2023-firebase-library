import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_library/firebase_options.dart';
import 'package:fire_library/providers/auth/firebase_auth_provider.dart';
import 'package:fire_library/providers/auth/mock_auth_provider.dart';
import 'package:fire_library/providers/book/firebase_book_provider.dart';
import 'package:fire_library/providers/book/mock_book_provider.dart';
import 'package:fire_library/providers/book_request/base_mock_book_request_provider.dart';
import 'package:fire_library/providers/book_request/firebase_book_request_provider.dart';
import 'package:fire_library/providers/library/firebase_library_provider.dart';
import 'package:fire_library/providers/library/mock_library_provider.dart';
import 'package:fire_library/ui/app.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firebaseAuth = auth.FirebaseAuth.instance;

  /// Firebase Auth Initialization
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  /// Firebase Firestore init
  final firebaseFirestore = FirebaseFirestore.instance;

  /// TODO(GP): Change to Firebase implementation here
  final authProvider = FirebaseAuthProvider(firebaseAuth);
  final bookProvider = FirebaseBookProvider(firebaseFirestore);
  final libraryPvodier = FirebaseLibraryProvider(firebaseFirestore);
  final bookRequestProvider = FirebasekBookRequestProvider(firebaseFirestore);

  runApp(
    LibraryApp(
      authProvider: authProvider,
      bookProvider: bookProvider,
      libraryProvider: libraryPvodier,
      bookRequestProvider: bookRequestProvider,
    ),
  );
}
