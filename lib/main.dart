import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'KytyApp.dart';
import 'firebase_options.dart';

void main() {



  KytyApp kytyApp = KytyApp();
  runApp( kytyApp);
  initFB();
}

void initFB() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

