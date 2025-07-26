import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/model/Event.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppTextStyle.dart';

import '../../../../provider/App_theme_Provider.dart';
import '../../../../provider/event list provider.dart';
import '../../../../provider/user provider.dart';
import '../../../../uitels/AppAssets.dart';


class ItemBuiltForListView extends StatelessWidget {
  Event event;

  ItemBuiltForListView({
    super.key,
    required this.event
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    var eventProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width*0.02
      ),
      height: height*0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(event.eventImage), fit: BoxFit.fill),
        border: Border.all(
          width: 2.5,
          color: AppColors.primaryColor
        ),
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: height*0.01,
              horizontal: width*0.02
            ),
            padding:EdgeInsets.symmetric(
              horizontal: width*0.025
              ),

            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(10),
              color: themeProvider.isDarkMode ?
              AppColors.wiehgtBlackBgColor : AppColors.whiteBgColor,
              border: Border.all(
                  width: 2.5,
                  color: AppColors.primaryColor
              ),
            ),child: Column(
              children: [
                Text(event.eventDateTime.day.toString(),
                  style: AppTextStyle.bold20Primary,),
                Text(DateFormat('MMM').format(event.eventDateTime),
                  style: AppTextStyle.bold20Primary,),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * 0.02,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // استخدم BorderRadius.circular بدلاً من BorderRadiusGeometry
              color: themeProvider.isDarkMode ?
              AppColors.wiehgtBlackBgColor : AppColors.whiteBgColor,
              border: Border.all(
                width: 2.5,
                color: AppColors.primaryColor,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.01,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      event.eventTitle,
                      style: themeProvider.isDarkMode ?
                      AppTextStyle.bold20White : AppTextStyle.bold20Black,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  InkWell(
                      onTap: () {
                        eventProvider.upDateThisFav(event,userProvider.currentUser!.id);
                      },
                      child:
                      event.isFavorite == true
                          ?
                      Image.asset(
                        AppAssets.selctedHeart, color: AppColors.primaryColor,)
                          :
                      Image.asset(
                        AppAssets.heart,
                        color: AppColors.primaryColor,
                      )

                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
Container(

            margin: EdgeInsets.symmetric(
                vertical: height*0.01,
                horizontal: width*0.02
            ),
            padding:EdgeInsets.symmetric(
                horizontal: width*0.1
            ),

            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(10),
              color: AppColors.whiteBgColor,
              border: Border.all(
                  width: 2.5,
                  color: AppColors.primaryColor
              ),
            ),child: Row(
            children: [
              Expanded(
                child: Text(
                  'This is a Birthday Party',
                  style: AppTextStyle.bold20Black,
                ),
              ),
              Image.asset(AppAssets.heart, color: AppColors.primaryColor),
            ],
          ),
          ),
 */