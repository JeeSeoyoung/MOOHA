import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:mooha/provider/ApplicationState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(const MoohaApp());
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationsState(),
    builder: ((context, child) => const MoohaApp()),
  ));
}
