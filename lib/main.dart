import 'package:cloneapp/firebase_options.dart';
import 'package:cloneapp/localization/locales.dart';
import 'package:cloneapp/pages/customeradd.dart';
import 'package:cloneapp/pages/customerpage.dart';
import 'package:cloneapp/pages/details.dart';
import 'package:cloneapp/pages/estimate.dart';
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
import 'package:cloneapp/pages/subpages/designpage.dart';
import 'package:cloneapp/pages/subpages/invoicedata.dart';
import 'package:cloneapp/pages/subpages/calendar.dart';
import 'package:cloneapp/pages/subpages/notespage.dart';
import 'package:cloneapp/pages/subpages/organisation.dart';
import 'package:cloneapp/pages/subpages/settings/applock.dart';
import 'package:cloneapp/pages/subpages/settings/customerdetails.dart';
import 'package:cloneapp/pages/subpages/settings/invoicedetails.dart';
import 'package:cloneapp/pages/subpages/settings/recover.dart';
import 'package:cloneapp/pages/subpages/settings/taskadd.dart';
import 'package:cloneapp/pages/subpages/profile.dart';
import 'package:cloneapp/pages/verify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
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

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final invoice;
  

  MyApp({super.key, this.invoice});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    configureLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var customerData;
    var invoiced;
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
    //  localizationsDelegates: const [
    //     GlobalMaterialLocalizations.delegate,
    //     GlobalWidgetsLocalizations.delegate,
    //     GlobalCupertinoLocalizations.delegate,
    //   ],
    //   supportedLocales: const [
    //     Locale('en', 'US'),
    //     Locale('de', 'DE'),
    //     Locale('zh', 'CN'),
    //   ],
      home:  const Open(
        ),
      
      routes: { 
        
        '/signup': (context) =>  Signup(),
        '/login': (context) => const Login(),
        '/home': (context) => Home(),
        '/estimate': (context) => const Estimate(),
        '/taskadd': (context) => const  taskaddScreen(),
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
        // '/invoiceadd': (context) => const InvoiceAdd(customerID: customerID),
        '/profile': (context) => const Profile(),
        // '/security': (context) =>  DialogExamplePage(),
        // '/about': (context) => InvoiceScreen(),
        // '/users': (context) =>  UsersScreen(),
        '/billingpage': (context) => BillingPage(invoice: widget.invoice),
        '/note': (context) => const Calendar(),
        '/notesadd': (context) => const NotesAddScreen(),
        // '/link_account': (context) => LinkAccountScreen(),
       '/preference': (context)=> const Preferences(),
        '/invoicetemplate':(context)=> const InvoiceTemplate(),
        '/verify':(context)=> const Verify(),
        '/password':(context)=>  DesignPage(),
        '/pw':(context)=>  Invoicedetails(customerData: customerData),
        '/notepage':(context)=> Notes(),
        '/customerdetail':(context)=>  CustomerDetails(customerData: customerData),
        '/billingpage2':(context)=> BillingPage2(invoicedData: invoiced),
        '/additems':(context)=> const AddItems()
       
      },
    );
  }
 void configureLocalization(){
  localization.init(mapLocales: LOCALES,initLanguageCode: "en");
  localization.onTranslatedLanguage = onTranslatedLanguage ;
  }
  void onTranslatedLanguage(Locale? locale){
    setState(() {
      
    });
  }
}

 // // Activate Firebase App Check with appropriate providers
  // await FirebaseAppCheck.instance.activate(
  //   // For web, use ReCaptchaV3Provider with your site key
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    
  //   // For Android, choose a provider (e.g., debug, SafetyNet, Play Integrity)
  //   androidProvider: AndroidProvider.debug,
    
  //   // For iOS/macOS, choose a provider (e.g., debug, Device Check, App Attest)
  //   appleProvider: AppleProvider.appAttest,
  // );