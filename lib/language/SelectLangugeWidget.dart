import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/l10n/app_localizations.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppTextStyle.dart';

import '../provider/App_Language_Provider.dart';

class SelectLangugeWidget extends StatefulWidget {
   SelectLangugeWidget({super.key});

  @override
  State<SelectLangugeWidget> createState() => _SelectLangugeWidgetState();
}

class _SelectLangugeWidgetState extends State<SelectLangugeWidget> {
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return
       Padding(
        padding:  EdgeInsets.symmetric(
        horizontal: width*0.04,
       vertical: height*0.02
        ),
        child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            InkWell(
              onTap: () {
            languageProvider.changeLanguage('en');
              },
               child: languageProvider.appLanguage=='en'?
                getSelectedLanguage(selectLanguage:  AppLocalizations.of(context)!.english):
                unGetSelectedLanguage(selectLanguage: AppLocalizations.of(context)!.english)
            ),
              SizedBox(height: height*0.01,),
              InkWell(
                onTap: () {
                  languageProvider.changeLanguage('ar');

                },
              child:    languageProvider.appLanguage=='ar'?
              getSelectedLanguage(selectLanguage:  AppLocalizations.of(context)!.arabic):
              unGetSelectedLanguage(selectLanguage: AppLocalizations.of(context)!.arabic)
              )

          ],
        ),
    );
  }
  Widget getSelectedLanguage({ required String selectLanguage}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(selectLanguage
          ,style: AppTextStyle.bold20Primary,
        ),
        Icon(Icons.check,color: AppColors.primaryColor,)
      ],
    );
  }
  Widget unGetSelectedLanguage({required String selectLanguage}){
    return Text(selectLanguage,style: AppTextStyle.bold20Black,);
  }
}
