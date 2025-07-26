import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/l10n/app_localizations.dart';
import 'package:untitled/uitels/AppAssets.dart';

import '../../uitels/AppColors.dart';
import '../../uitels/AppTextStyle.dart';
import '../loop widgets/Custom_Text_Form.dart';

class ForgetPassword extends StatefulWidget {
 ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
 var formKey = GlobalKey<FormState>();

 var email =TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading:InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color:Theme.of(context)!.iconTheme.color),
        ) ,
        backgroundColor: Theme.of(context)!.scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.forget_password
          ,style: Theme.of(context)!.textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: width*0.03
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppAssets.resetPass),
              SizedBox(height: height*0.05,),
              Form(
                key: formKey,
                child: CustomTextForm(
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
              ),
              SizedBox(height: height*0.05,),
              SizedBox(
                width:double.infinity,
                child: FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: resetPassword
                  ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.reset_password,style: AppTextStyle.bold20White,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Future<void> resetPassword() async {
   if (formKey.currentState?.validate() == true) {
     try {
       await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim());
       Fluttertoast.showToast(
         toastLength: Toast.LENGTH_SHORT,
         timeInSecForIosWeb: 1,
         backgroundColor: AppColors.primaryColor,
         textColor: Colors.white,
         fontSize: 16,
         msg: 'password reset email sent',
       );
       Navigator.pop(context);
     } on FirebaseAuthException catch (e) {
       Fluttertoast.showToast(
         msg: e.message ?? 'An error occurred',
         backgroundColor: Colors.red,
         textColor: Colors.white,
       );
     }
   }
 }
}
