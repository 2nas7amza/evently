import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/l10n/app_localizations_ar.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppRoutes.dart';
import 'package:untitled/uitels/AppTextStyle.dart';

import '../l10n/app_localizations.dart';
import '../uitels/AppAssets.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool isLastPage= false;
final controller = PageController();
@override
void dispose(){
  controller.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: width*0.05
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.logoTop),

              SizedBox(
                  height: height*0.75,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (index) {
                      setState(()=> isLastPage =index==2);
                    },
                    children: [

                      contenPageView(
                        image: AppAssets.catBoarding,
                        firstText: AppLocalizations.of(context)!.find_events_that_inspire_you,
                        SecondText: AppLocalizations.of(context)!.first_on_boarding,),
                      contenPageView(
                        image: AppAssets.columnBoarding,
                        firstText: AppLocalizations.of(context)!.effortless_event_planning,
                        SecondText: AppLocalizations.of(context)!.second_on_boarding,),
                      contenPageView(
                        image: AppAssets.creativeBoarding,
                        firstText: AppLocalizations.of(context)!.connect_with_friends_share_moments,
                        SecondText: AppLocalizations.of(context)!.third_on_boarding,),

                    ],
                  ),
                ),

              Container(
                child: isLastPage ?
                    SizedBox(
                      width: double.infinity,
                      child: FloatingActionButton(
                        backgroundColor: AppColors.primaryColor,
                        onPressed: () {
                       Navigator.of(context).pushNamed(AppRoutes.signIn);
                      },
                      child: Text(AppLocalizations.of(context)!.lets_start),
                      ),
                    ) :
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                    onTap: () =>controller.previousPage(
                        duration: Duration(
                          milliseconds: 500
                        ),
                        curve: Curves.easeInOut),
                child: Icon(Icons.arrow_circle_left_outlined,color: AppColors.primaryColor,size: 50,)),

                    Center(
                      child: SmoothPageIndicator(
                          controller: controller,
                          count: 3),
                    ),
                    InkWell(
                      onTap: () => controller.nextPage(
                          duration:  Duration(
                      milliseconds: 500
                          ) ,
                          curve: Curves.easeInOut
                      )
                      ,child:
                    Icon(Icons.arrow_circle_right_outlined,color: AppColors.primaryColor,size: 50,),),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class contenPageView extends StatelessWidget {
  String image;
  String firstText;
  String SecondText;
   contenPageView({
     super.key,
      required String this.image,
     required String this.firstText,
     required String this.SecondText,

   });

  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return  Column(
      children: [
        Image.asset(image),
        SizedBox(height: height*0.03,),
        Text(firstText,
        style: AppTextStyle.bold20Primary,
        ),
        SizedBox(height: height*0.02,),
        Text(SecondText,
          style: Theme.of(context)!.textTheme.headlineLarge,
        ),
      ],
    );
  }
}
