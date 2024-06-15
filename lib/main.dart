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
// ignore: unused_import
import 'package:cloneapp/pages/login.dart';
import 'package:cloneapp/pages/open.dart';
import 'package:cloneapp/pages/paymentlink.dart';
import 'package:cloneapp/pages/paymentreceived.dart';
import 'package:cloneapp/pages/report.dart';
import 'package:cloneapp/pages/setting.dart';
import 'package:cloneapp/pages/signup.dart';
import 'package:cloneapp/pages/subpages/addnotes.dart';
import 'package:cloneapp/pages/subpages/billing.dart';
import 'package:cloneapp/pages/subpages/notes.dart';
import 'package:cloneapp/pages/subpages/security.dart';
import 'package:cloneapp/pages/subpages/users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options :DefaultFirebaseOptions.currentPlatform,
  );
  var invoice;
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Open(),
    routes: {
      '/signup':(context)=> const Signup(),
      '/login':(context)=>  const Login(),
      '/home':(context)=>  Home(),
      '/estimate':(context)=>  const Estimate(),
      '/expense':(context) => const Expense(),
      '/invoice':(context) => const InvoiceView(),
      '/paymentlink':(context) => const Paymentlink(),
      '/paymentreceive':(context) => const Paymentreceived(),
      '/report':(context) => const Report(),
      '/setting':(context) => const Setting(),
      '/customer':(context)=> const Customeradd(),
      '/customeradd':(context)=> const Customerpage(),
      '/details':(context)=> const Details(),
      '/item':(context)=> const Items(),
      '/itemadd':(context)=> const Itemadd(),
      '/invoiceadd':(context)=> const Invoiceadd(),
      // '/rule':(context)=> const Rules(),
      '/security':(context)=> const Security(),
      // '/about':(context)=> InvoiceListPage(),
      '/users':(context)=> const Users(),
      '/billingpage':(context)=>  BillingPage(invoice: invoice),
      '/note':(context)=> const Notes(),
      '/notesadd': (context)=>  NotesAddScreen(),
     
    },
    
  )
  );
}


