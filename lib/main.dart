import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/controllers/admin_provider.dart';
import 'package:admin/firebase_options.dart';
import 'package:admin/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async{

    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
   runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) =>MenuAppController()),
      ChangeNotifierProvider(create: (context) => AdminProvider()),
    ],
    child:  MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<AdminProvider>(context,listen: false).getData();  
    return MaterialApp(
         builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
  routes: routes,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      
      
      
    );
  }
}
