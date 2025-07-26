import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/l10n/app_localizations.dart';
import 'package:untitled/provider/App_theme_Provider.dart';
import 'package:untitled/uitels/AppAssets.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppRoutes.dart';
import 'package:untitled/uitels/AppTextStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/App_Language_Provider.dart';

class FirstOnBoarding extends StatefulWidget {
  const FirstOnBoarding({super.key});

  @override
  State<FirstOnBoarding> createState() => _FirstOnBoardingState();
}

class _FirstOnBoardingState extends State<FirstOnBoarding> {
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(
             horizontal: width*0.1,
            vertical: height*0.01
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.center ,
              children: [
                   Image.asset(AppAssets.logoTop),
                   SizedBox(height: height*0.02,),
                    Image.asset(AppAssets.beingCreative),
                    SizedBox(height: height*0.02,),
                    Text(
                      AppLocalizations.of(context)!.personalize_your_experience,
                      style: AppTextStyle.bold20Primary,
                    ),
                     SizedBox(height: height*0.02,),
                     Text(AppLocalizations.of(context)!.choose_your_preferred_theme_and_language_to_get_started_with_comfortable_tailored_experience_that_suits_your_style
                       ,style: Theme.of(context).textTheme.headlineLarge,

                ),
                     SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.language,style: AppTextStyle.normal20Primary,),
                    Spacer(),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width*0.02,
                          vertical: height*0.01
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1,
                                color: AppColors.primaryColor
                            )
                        ),child: Row(
                        children:[
                          InkWell(
                            onTap: () async {
                              await languageProvider.changeLanguage('ar');
                            },
                            child: context.watch<AppLanguageProvider>().appLanguage == 'ar'
                                ? selecteItem(image: AppAssets.egyptLogo)
                                : unSelecteItem(image: AppAssets.egyptLogo),
                          ),
                         SizedBox(width: width*0.09,),
                          InkWell(
                            onTap: () async {
                              await languageProvider.changeLanguage('en');

                            },
                            child: context.watch<AppLanguageProvider>().appLanguage == 'en'
                                ? selecteItem(image: AppAssets.usLogo)
                                : unSelecteItem(image: AppAssets.usLogo),
                          ),
                        ]

                    )
                    )

                  ],
                ),
                SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.theme,style: AppTextStyle.normal20Primary,),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width*0.02,
                          vertical: height*0.01
                      ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1,
                                color: AppColors.primaryColor
                            )
                        ),child: Row(
                        children:[
                          InkWell(
                              onTap: () async{

                               await themeProvider.changeTheme(ThemeMode.light);

                              },
                              child: themeProvider == ThemeMode.light?
                              selecteItem(image: AppAssets.sun,):
                              unSelecteItem(image: AppAssets.sun,)
                          ),
                          SizedBox(width: width*0.02,),
                          InkWell(
                              onTap: () async{

                                   await themeProvider.changeTheme(ThemeMode.dark);

                              },
                              child: themeProvider == ThemeMode.dark?
                              selecteItem(image: AppAssets.moon,):
                              unSelecteItem(image: AppAssets.moon)

                          ),
                        ]

                    )
                    )

                  ],
                ),
                SizedBox(height: height*0.05,),
                SizedBox(
                  width: double.infinity,
                  child: FloatingActionButton(onPressed: () {
                     Navigator.of(context).pushNamed(AppRoutes.Onboarding);
                  },
                    backgroundColor: AppColors.primaryColor,
                  child:
                  Text(AppLocalizations.of(context)!.lets_start,style: AppTextStyle.bold20White,),

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget selecteItem(

  {

    required String image,
})

  {

    return
        Container(
          padding: EdgeInsets.all(4),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryColor,
              width:2
            ),

          ),child: Image.asset(image,),
           );


  }
  Widget unSelecteItem( {
    required String image
  }){
    return
      Container(
        child: Image.asset(image),
      );


  }

}



