import 'package:flutter/material.dart' show runApp;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:canli_skor/di.dart';
import 'app.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  setupDependencies();
  runApp(const LiveScoreApp());
}
