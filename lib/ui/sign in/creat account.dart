import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled/l10n/app_localizations.dart';
import 'package:untitled/model/my%20user.dart';
import 'package:untitled/ui/loop%20widgets/Custom_Text_Form.dart';
import 'package:untitled/uitels/AppAssets.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppTextStyle.dart';
import 'package:untitled/uitels/firebaseuitles.dart';

import '../../provider/App_Language_Provider.dart';
import '../../provider/user provider.dart';
import '../../uitels/AppRoutes.dart';

class CreatAccount extends StatefulWidget {
   CreatAccount({super.key});

   @override
   State<CreatAccount> createState() => _CreatAccountState();
}

class _CreatAccountState extends State<CreatAccount> {
  var formKey = GlobalKey<FormState>();
  var name = TextEditingController(text: 'anas');
  var email = TextEditingController(text: 'hans16486@gmail.com');
  var password = TextEditingController(text: '12345678');
  var rePassword = TextEditingController(text: '12345678');

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
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Theme
              .of(context)!
              .iconTheme
              .color),
        ),
        backgroundColor: Theme.of(context)!.scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.create_account
          , style: Theme
              .of(context)!
              .textTheme
              .titleMedium,
        ),
      ),
      body: SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04
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
                            return 'Pleas enter name';
                          }
                          return null;
                        }, controller: name,
                        hintText: AppLocalizations.of(context)!.name,
                        prefixIcon: Icon(
                          Icons.person, color: AppColors.greyColor,),
                      ),
                      SizedBox(height: height * 0.01,),
                      CustomTextForm(
                        controller: email,
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return 'Pleas enter email';
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.email,
                        prefixIcon: Icon(
                          Icons.mail, color: AppColors.greyColor,),
                      ),
                      SizedBox(height: height * 0.02,),
                      CustomTextForm(

                        controller: password,
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return 'Pleas enter password';
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.password,
                        prefixIcon: Icon(
                          Icons.lock, color: AppColors.greyColor,),
                        suffixIcon: Icon(
                          Icons.remove_red_eye, color: AppColors.greyColor,),
                      ),
                      SizedBox(height: height * 0.02,),
                      CustomTextForm(

                        controller: rePassword,
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return 'Pleas enter re password';
                          }
                          if (text != password.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.re_password,
                        prefixIcon: Icon(
                          Icons.lock, color: AppColors.greyColor,),
                        suffixIcon: Icon(
                          Icons.remove_red_eye, color: AppColors.greyColor,),
                      ),
                    ],
                  )),
              SizedBox(height: height * 0.02,),

              SizedBox(
                width: double.infinity,
                child: FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                  register();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.create_account,
                        style: AppTextStyle.bold20White,),

                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.already_have_account,
                    style: Theme
                        .of(context)!
                        .textTheme
                        .headlineLarge,
                  ),
                  TextButton(

                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.signIn);
                      }, child: Text(
                      AppLocalizations.of(context)!.log_in,
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

  void register() async {
    if (formKey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        MyUser myUser = MyUser(
          id: credential.user?.uid ?? '',
          name: name.text,
          email: email.text,
        );
        await FirebaseLogic.adduserToFireBase(myUser);
        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(myUser);

        Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'حدث خطأ';
        if (e.code == 'weak-password') {
          errorMessage = 'كلمة المرور ضعيفة';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'البريد الإلكتروني مستخدم بالفعل';
        }
        Fluttertoast.showToast(msg: errorMessage);
      }
    }
  }
}