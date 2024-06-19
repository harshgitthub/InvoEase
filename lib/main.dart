// import 'package:cloneapp/firebase_options.dart';
// import 'package:cloneapp/pages/customeradd.dart';
// import 'package:cloneapp/pages/customerpage.dart';
// import 'package:cloneapp/pages/details.dart';
// import 'package:cloneapp/pages/estimate.dart';
// import 'package:cloneapp/pages/expense.dart';
// import 'package:cloneapp/pages/home.dart';
// import 'package:cloneapp/pages/invoice.dart';
// import 'package:cloneapp/pages/invoiceadd.dart';
// import 'package:cloneapp/pages/itemadd.dart';
// import 'package:cloneapp/pages/items.dart';
// // ignore: unused_import
// import 'package:cloneapp/pages/login.dart';
// import 'package:cloneapp/pages/open.dart';
// import 'package:cloneapp/pages/paymentlink.dart';
// import 'package:cloneapp/pages/paymentreceived.dart';
// import 'package:cloneapp/pages/report.dart';
// import 'package:cloneapp/pages/setting.dart';
// import 'package:cloneapp/pages/signup.dart';
// import 'package:cloneapp/pages/subpages/addnotes.dart';
// import 'package:cloneapp/pages/subpages/billing.dart';
// import 'package:cloneapp/pages/subpages/notes.dart';
// import 'package:cloneapp/pages/subpages/security.dart';
// import 'package:cloneapp/pages/subpages/users.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';



// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options :DefaultFirebaseOptions.currentPlatform,
//   );
//   var invoice;

//   runApp( MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: const Open(),
//     routes: {
//       '/signup':(context)=> const Signup(),
//       '/login':(context)=>  const Login(),
//       '/home':(context)=>  Home(),
//       '/estimate':(context)=>  const Estimate(),
//       '/expense':(context) => const Expense(),
//       '/invoice':(context) => const InvoiceView(),
//       '/paymentlink':(context) => const Paymentlink(),
//       '/paymentreceive':(context) => const Paymentreceived(),
//       '/report':(context) => const Report(),
//       '/setting':(context) => const Setting(),
//       '/customer':(context)=> const Customeradd(),
//       '/customeradd':(context)=> const Customerpage(),
//       '/details':(context)=> const Details(),
//       '/item':(context)=> const Items(),
//       '/itemadd':(context)=> const Itemadd(),
//       '/invoiceadd':(context)=> const Invoiceadd(),
//       // '/rule':(context)=> const Rules(),
//       '/security':(context)=> const Security(),
//       // '/about':(context)=> InvoiceListPage(),
//       '/users':(context)=> const Users(),
//       '/billingpage':(context)=>  BillingPage(invoice: invoice),
//       '/note':(context)=> const Notes(),
//       '/notesadd': (context)=>  const NotesAddScreen(),
     
//     },
    
//   )
//   );
// }

import 'package:cloneapp/firebase_options.dart';
import 'package:cloneapp/pages/customeradd.dart';
import 'package:cloneapp/pages/customerpage.dart';
import 'package:cloneapp/pages/details.dart';
import 'package:cloneapp/pages/estimate.dart';
import 'package:cloneapp/pages/expense.dart';
import 'package:cloneapp/pages/home.dart';
import 'package:cloneapp/pages/invoice.dart';
import 'package:cloneapp/pages/invoiceadd.dart';
import 'package:cloneapp/pages/itemadd.dart';
import 'package:cloneapp/pages/items.dart';
import 'package:cloneapp/pages/login.dart';
import 'package:cloneapp/pages/open.dart';
import 'package:cloneapp/pages/paymentlink.dart';
import 'package:cloneapp/pages/paymentreceived.dart';
import 'package:cloneapp/pages/report.dart';
import 'package:cloneapp/pages/setting.dart';
import 'package:cloneapp/pages/signup.dart';
import 'package:cloneapp/pages/subpages/about.dart';
import 'package:cloneapp/pages/subpages/addnotes.dart';
import 'package:cloneapp/pages/subpages/billing.dart';
import 'package:cloneapp/pages/subpages/invoicedata.dart';
import 'package:cloneapp/pages/subpages/notes.dart';
import 'package:cloneapp/pages/subpages/settings/applock.dart';
import 'package:cloneapp/pages/subpages/share.dart';
import 'package:cloneapp/pages/subpages/users.dart';
import 'package:cloneapp/pages/verify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';


void main() async {
    // Ensure Flutter binding is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage (if needed)
  await Hive.initFlutter();

  // Initialize Firebase with default options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // // Activate Firebase App Check with appropriate providers
  // await FirebaseAppCheck.instance.activate(
  //   // For web, use ReCaptchaV3Provider with your site key
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    
  //   // For Android, choose a provider (e.g., debug, SafetyNet, Play Integrity)
  //   androidProvider: AndroidProvider.debug,
    
  //   // For iOS/macOS, choose a provider (e.g., debug, Device Check, App Attest)
  //   appleProvider: AppleProvider.appAttest,
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final invoice;

  MyApp({super.key, this.invoice});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  const Open(
          // onGoogleSignIn: () {
          //   // Handle Google Sign-In callback here
          //   Navigator.pushReplacementNamed(context, '/details');
          // },
        ),
      routes: { 
        
        '/signup': (context) =>  Signup(),
        '/login': (context) => const Login(),
        '/home': (context) => Home(),
        '/estimate': (context) => const Estimate(),
        '/expense': (context) => const Expense(),
        '/invoice': (context) => const InvoiceView(),
        '/paymentlink': (context) => const Paymentlink(),
        '/paymentreceive': (context) => const Paymentreceived(),
        '/report': (context) => const Report(),
        '/setting': (context) => const Setting(),
        '/customer': (context) =>  const Customeradd(),
        '/customeradd': (context) => const Customerpage(),
        '/details': (context) => const Details(),
        '/item': (context) => const Items(),
        '/itemadd': (context) => const Itemadd(),
        '/invoiceadd': (context) => const Invoiceadd(),
        '/profile': (context) => const Profile(),
        '/security': (context) => const Applock(),
        '/about': (context) => InvoiceScreen(),
        '/users': (context) => const Users(),
        '/billingpage': (context) => BillingPage(invoice: invoice),
        '/note': (context) => const Notes(),
        '/notesadd': (context) => const NotesAddScreen(),
        // '/link_account':(context)=>  LinkAccountScreen(),
        // '/applock':(context)=> const Applock(),
        '/invoicetemplate':(context)=> const Invoicedata(),
        '/verify':(context)=> const Verify(),
      },
    );
  }
}
