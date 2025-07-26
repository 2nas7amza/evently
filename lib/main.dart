import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/event%20deatils/Edit_Event.dart';
import 'package:untitled/onBoarding/first%20onBoarding.dart';
import 'package:untitled/provider/App_Language_Provider.dart';
import 'package:untitled/provider/App_theme_Provider.dart';
import 'package:untitled/provider/event%20list%20provider.dart';
import 'package:untitled/provider/user%20provider.dart';
import 'package:untitled/ui/home/homescreen.dart';
import 'package:untitled/ui/home/tabs/add%20event/Add_Event.dart';
import 'package:untitled/ui/sign%20in/Sign_In.dart';
import 'package:untitled/ui/sign%20in/creat%20account.dart';
import 'package:untitled/ui/sign%20in/forget%20password.dart';
import 'package:untitled/uitels/AppRoutes.dart';
import 'package:untitled/uitels/AppTheme.dart';

import 'event deatils/Event_Deatails.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'model/Event.dart';
import 'onBoarding/onBoarding.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final languageProvider = AppLanguageProvider();
  await languageProvider.initialize();

  final themeProvider = AppThemeProvider();
  await themeProvider.initialize();
  runApp(MultiProvider(

      providers: [
       ChangeNotifierProvider(   create:(context) => languageProvider,),
        ChangeNotifierProvider(create: (context) => themeProvider,),
        ChangeNotifierProvider(create: (context) => EventListProvider(),),
        ChangeNotifierProvider(create: (context) => UserProvider(),),
      ],
      child: MyApp()));

}

class MyApp extends StatelessWidget {
 
   MyApp({super.key});
   

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     var languageProvider= Provider.of<AppLanguageProvider>(context);
     var themeProvider= Provider.of<AppThemeProvider>(context);

     return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
       initialRoute: AppRoutes.signIn,
       locale: Locale(context.watch<AppLanguageProvider>().appLanguage),
       routes: {
        AppRoutes.firstOnboarding:(context)=> FirstOnBoarding(),
        AppRoutes.Onboarding:(context)=> OnBoarding(),
        AppRoutes.signIn:(context)=> SignIn(),
        AppRoutes.homeScreen:(context)=> HomeScreen(),
         AppRoutes.createAccount:(context)=> CreatAccount(),
         AppRoutes.rePassword:(context)=> ForgetPassword(),
         AppRoutes.addEvent:(context)=> Addinv(),
         AppRoutes.eventDetails:(context)=> Ed(),
         AppRoutes.eventEdit: (context) => EditEvent(),

       },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
