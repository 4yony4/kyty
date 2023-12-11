import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kyty/Singletone/DataHolder.dart';

import 'KytyApp.dart';
import 'firebase_options.dart';

void main() async{
  Stripe.publishableKey = "pk_test_QSBUITcb1wxJvulIeqykEvhS00JXKNrFUv";

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  DataHolder().initDataHolder();
  KytyApp kytyApp = KytyApp();
  runApp( kytyApp);


}
