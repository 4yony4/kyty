import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Singletone/DataHolder.dart';

import 'KytyApp.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  DataHolder().initDataHolder();
  KytyApp kytyApp = KytyApp();
  runApp( kytyApp);


}
