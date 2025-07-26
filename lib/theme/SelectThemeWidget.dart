import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/l10n/app_localizations.dart';
import 'package:untitled/provider/App_theme_Provider.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppTextStyle.dart';

import '../provider/App_Language_Provider.dart';

class SelectThemeWidget extends StatefulWidget {
   SelectThemeWidget({super.key});

  @override
  State<SelectThemeWidget> createState() => _SelectThemeWidgetState();
}

class _SelectThemeWidgetState extends State<SelectThemeWidget> {
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
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
            themeProvider.changeTheme(ThemeMode.light);
              },
               child:  themeProvider.appTheme== ThemeMode.light?
                getSelectedLanguage(selectLanguage:  AppLocalizations.of(context)!.light):
                unGetSelectedLanguage(selectLanguage: AppLocalizations.of(context)!.light)
            ),
              SizedBox(height: height*0.01,),
              InkWell(
                onTap: () {
                  themeProvider.changeTheme(ThemeMode.dark);
                },
              child:    themeProvider.appTheme== ThemeMode.dark?
              getSelectedLanguage(selectLanguage:  AppLocalizations.of(context)!.dark):
              unGetSelectedLanguage(selectLanguage: AppLocalizations.of(context)!.dark)
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
