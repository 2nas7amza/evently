import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:untitled/l10n/app_localizations.dart';
import 'package:untitled/provider/user%20provider.dart';
import 'package:untitled/ui/loop%20widgets/Custom_Text_Form.dart';
import 'package:untitled/uitels/AppAssets.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppRoutes.dart';
import 'package:untitled/uitels/AppTextStyle.dart';
import 'package:untitled/uitels/firebaseuitles.dart';

import '../../provider/App_Language_Provider.dart';
import '../../provider/event list provider.dart';

class SignIn extends StatefulWidget {

  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController(
      text: 'hans16486@gmail.com');

  TextEditingController password = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.02
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppAssets.logo),
              SizedBox(height: height * 0.01,),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextForm(
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return 'Pleas enter email';
                          }
                          return null;
                        },
                        controller: email,
                        hintText: AppLocalizations.of(context)!.email,
                        prefixIcon: Icon(
                          Icons.mail, color: AppColors.greyColor,),
                      ),
                      SizedBox(height: height * 0.02,),
                      CustomTextForm(
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return 'Pleas enter password';
                          }
                          return null;
                        }
                        ,
                        controller: password,
                        hintText: AppLocalizations.of(context)!.password,
                        prefixIcon: Icon(
                          Icons.lock, color: AppColors.greyColor,),
                        suffixIcon: Icon(
                          Icons.remove_red_eye, color: AppColors.greyColor,),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(

                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.rePassword);
                      }, child: Text(
                      AppLocalizations.of(context)!.forget_password,
                      style: AppTextStyle.bold16Primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor
                      )
                  )
                  )
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                    login();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.log_in,
                        style: AppTextStyle.bold20White,),

                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.dont_have_account,
                    style: Theme
                        .of(context)!
                        .textTheme
                        .headlineLarge,
                  ),
                  TextButton(

                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            AppRoutes.createAccount);
                      }, child: Text(
                      AppLocalizations.of(context)!.create_account,
                      style: AppTextStyle.bold16Primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor
                      )
                  )
                  )
                ],
              ),
              SizedBox(height: height * 0.02,),
              Row(
                children: [
                  Expanded(child: Divider(
                    color: AppColors.primaryColor,
                    thickness: 2,
                    indent: width * 0.01,
                    endIndent: width * 0.01,
                  )),
                  Text('or', style: AppTextStyle.bold20Primary,),
                  Expanded(child: Divider(
                    color: AppColors.primaryColor,
                    thickness: 2,
                    indent: width * 0.01,
                    endIndent: width * 0.01,
                  )),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          width: 1,
                          color: AppColors.primaryColor
                      )
                  ),
                  child: FloatingActionButton(
                    backgroundColor: AppColors.whiteBgColor,
                    onPressed: () async {
                      bool isSignedIn = await loginWithGoogle();
                      if(isSignedIn){
                        Navigator.of(context).pushNamed(AppRoutes.homeScreen);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.googleLogo),
                        SizedBox(width: width * 0.01,),
                        Text(AppLocalizations.of(context)!.login_with_google,
                          style: AppTextStyle.bold20Primary,),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: height * 0.01
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              width: 2,
                              color: AppColors.primaryColor
                          )
                      ), child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            await languageProvider.changeLanguage('ar');
                          },
                          child: context
                              .watch<AppLanguageProvider>()
                              .appLanguage == 'ar'
                              ? selecteItem(image: AppAssets.egyptLogo)
                              : unSelecteItem(image: AppAssets.egyptLogo),
                        ),
                        SizedBox(width: width * 0.04,),
                        InkWell(
                          onTap: () async {
                            await languageProvider.changeLanguage('en');
                          },
                          child: context
                              .watch<AppLanguageProvider>()
                              .appLanguage == 'en'
                              ? selecteItem(image: AppAssets.usLogo)
                              : unSelecteItem(image: AppAssets.usLogo),
                        ),
                      ]

                  )
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget selecteItem({

    required String image,
  }) {
    return
      Container(
        padding: EdgeInsets.all(4),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: AppColors.primaryColor,
              width: 2
          ),

        ), child: Image.asset(image,),
      );
  }

  Widget unSelecteItem({
    required String image
  }) {
    return
      Container(
        child: Image.asset(image),
      );
  }

   login() async {
    if (formKey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text,
            password: password.text
        );
        var user=await FirebaseLogic.readUserFromFireStore(credential.user?.uid??"");
        if(user==null){
          return;
        }
        var userProvider=Provider.of< UserProvider>(context,listen: false);
        userProvider.updateUser(user);
        // var eventProvider=Provider.of<EventListProvider>(context);
        // // eventProvider.changeSelectIndex(0, credential.user!.uid);
        // eventProvider.getFavList(credential.user!.uid);
        Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
        print('id:${credential.user!.uid}');
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryColor,
            textColor: Colors.white,
            fontSize: 16,
            msg: 'Wrong password provided for that user.', );
        }else if (e.code == 'network-request-failed') {
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.primaryColor,
              textColor: Colors.white,
              fontSize: 16,
              msg: 'pleas cheack your network.');
        }

      }
      catch(e){
        print(e.toString());
      }
    }
   }

 Future<bool> loginWithGoogle() async {
  final user= await GoogleSignIn().signIn();
  GoogleSignInAuthentication googleUser = await user!.authentication;
  var credential = GoogleAuthProvider.credential(accessToken:googleUser.accessToken
      ,idToken:googleUser.accessToken );
     FirebaseAuth.instance.signInWithCredential(credential);
     return FirebaseAuth.instance.currentUser!= null ;
  }

}


