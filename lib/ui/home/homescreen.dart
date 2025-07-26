import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/l10n/app_localizations.dart';
import 'package:untitled/ui/home/tabs/favorite/FavoriteTab.dart';
import 'package:untitled/ui/home/tabs/home/HomeTab.dart';
import 'package:untitled/ui/home/tabs/map/MapsTab.dart';
import 'package:untitled/ui/home/tabs/profile/ProfileTab.dart';
import 'package:untitled/uitels/AppAssets.dart';
import 'package:untitled/uitels/AppRoutes.dart';

import '../../provider/user provider.dart';
import '../../uitels/AppColors.dart';

class HomeScreen extends StatefulWidget{
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    int selectIndex =0 ;
   List<Widget> tabs=[
     HomeTab(),MapsTab(),FavoriteTab(),ProfileTab()
   ];
  @override
  Widget build(BuildContext context) {

    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       floatingActionButton: FloatingActionButton(
         shape:RoundedRectangleBorder(
           borderRadius: BorderRadiusGeometry.circular(30),
          side:BorderSide(
               width: 4,
               color: AppColors.whiteBgColor
           ),
         ),
           onPressed:() {
           Navigator.of(context).pushNamed(AppRoutes.addEvent);
           },

           child: Icon(Icons.add,color: AppColors.whiteBgColor,) ,

       ),
      bottomNavigationBar:BottomNavigationBar(

          currentIndex: selectIndex,
              onTap: (index) {
                selectIndex = index;
                setState(() {

                });
              },
              items: [
                BottomNavigationBarItem(icon: buildBNB(index: 0, imageName: AppAssets.home),label:AppLocalizations.of(context)!.home ),
                BottomNavigationBarItem(icon: buildBNB(index: 1, imageName: AppAssets.location),label:AppLocalizations.of(context)!.map ),
                BottomNavigationBarItem(icon: buildBNB(index: 2, imageName: AppAssets.heart),label:AppLocalizations.of(context)!.favorite ),
                BottomNavigationBarItem(icon: buildBNB(index: 3, imageName: AppAssets.person),label:AppLocalizations.of(context)!.profile),
              ]),
      body: SafeArea(
        child: Column(
            children: [
            Expanded(child: tabs[selectIndex])
        ] ),
      )
    );
  }
    Widget buildBNB({required int index,required String imageName}){
      return selectIndex == index?
      ImageIcon(AssetImage(imageName))
      : ImageIcon(AssetImage(imageName)

      );
    }
}

