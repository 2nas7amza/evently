import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/App_theme_Provider.dart';
import 'package:untitled/theme/SelectThemeWidget.dart';
import 'package:untitled/uitels/AppAssets.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppRoutes.dart';
import 'package:untitled/uitels/AppTextStyle.dart';
import 'package:untitled/uitels/AppTheme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../language/SelectLangugeWidget.dart';
import '../../../../provider/App_Language_Provider.dart';
import '../../../../provider/event list provider.dart';
import '../../../../provider/user provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var eventProvider=Provider.of<EventListProvider>(context);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height*0.2,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60)
              )
            ),child: Row(

            children: [
              SizedBox(width: width*0.05,),
              Image.asset(AppAssets.profileImage),
              SizedBox(
                width: width*0.03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(userProvider.currentUser!.name,style: AppTextStyle.bold24White,),
                  Text(userProvider.currentUser!.email,style: AppTextStyle.bold16White,)

                ],
              )
            ],
          ),
          ),
          SizedBox(height: height*0.05,),
         Padding(padding: EdgeInsets.symmetric(
           horizontal: width*0.03
         ),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             Text(AppLocalizations.of(context)!.language,
             style: Theme.of(context).textTheme.headlineLarge,
             ),
             SizedBox(height: height*0.02,),
             Container(
               padding: EdgeInsets.symmetric(
                 vertical: height*0.02,
                 horizontal: width*0.01
               ),
               decoration: BoxDecoration(
                 border: Border.all(
                   color: AppColors.primaryColor,
                   width: 2
                 ),
                 borderRadius: BorderRadius.circular(16)
               ),child: InkWell(
               onTap: () {
                 selectLanguage();
               },
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(languageProvider.appLanguage=='en'?
                   AppLocalizations.of(context)!.english:
                   AppLocalizations.of(context)!.arabic
                     ,style: AppTextStyle.bold20Primary,),
                   Icon(Icons.arrow_drop_down,color: AppColors.primaryColor,)
                 ],
                              ),
               ),
             ),
             SizedBox(height: height*0.02,),
             Text(AppLocalizations.of(context)!.theme,
               style:Theme.of(context).textTheme.headlineLarge,
             ),
             SizedBox(height: height*0.02,),
             Container(
               padding: EdgeInsets.symmetric(
                   vertical: height*0.02,
                   horizontal: width*0.01
               ),
               decoration: BoxDecoration(
                   border: Border.all(
                       color: AppColors.primaryColor,
                       width: 2
                   ),
                   borderRadius: BorderRadius.circular(16)
               ),child: InkWell(
               onTap: () {
                  selectTheme();
               },
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text( themeProvider.appTheme == ThemeMode.light ?
                       AppLocalizations.of(context)!.light
                     : AppLocalizations.of(context)!.dark,
                     style: AppTextStyle.bold20Primary,),
                   Icon(Icons.arrow_drop_down,color: AppColors.primaryColor,)
                 ],
               ),
             ),
             ),
             SizedBox(height: height*0.1,),
             SizedBox(
               width:double.infinity,
               child: FloatingActionButton(
                 backgroundColor: Colors.red,
                 onPressed: () {
                   eventProvider.getFavEvent=[];
                    eventProvider.filterEventList=[];
                   Navigator.of(context).pushNamedAndRemoveUntil(
                     AppRoutes.signIn,
                         (route) => false,
                   );
               },
               child: Row(
                 children: [
                   Icon(Icons.exit_to_app,color: AppColors.whiteBgColor,size: 40,),
                  Text(AppLocalizations.of(context)!.log_out,style: AppTextStyle.bold20White,),

               ],
               ),
               ),
             )
           ],
         ),
         )
        ],
      )
    ;
  }

  void selectLanguage() {
 showModalBottomSheet(
     context: context,
     builder:(context)=>SelectLangugeWidget());
  }

  void selectTheme() {
    showModalBottomSheet(context: context,
        builder: (context) => SelectThemeWidget()
    );
  }
}


