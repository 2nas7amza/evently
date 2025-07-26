import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/event%20list%20provider.dart';
import 'package:untitled/ui/home/tabs/home/Item_Built_For_ListVeiw.dart';
import 'package:untitled/uitels/AppAssets.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppTextStyle.dart';
import 'package:untitled/uitels/AppRoutes.dart';
import '../../../../provider/App_theme_Provider.dart';
import '../../../../provider/user provider.dart';
import 'defult controler.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
    var eventProvider = Provider.of<EventListProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    eventProvider.getEventNameList(context);
    if (eventProvider.eventList.isEmpty) {
      eventProvider.getAllEvents(userProvider.currentUser!.id);
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: AppBar(
          automaticallyImplyLeading: false,
                  toolbarHeight: height*0.1,
          title: Column(
            children: [
             Row(
               children: [
                 ImageIcon(AssetImage(AppAssets.location),color: AppColors.whiteBgColor,),
                  Text('Cairo , Egypt', style: AppTextStyle.bold16White,)
               ],
             ),
              SizedBox(height: height*0.005,),
              DefaultTabController(
                  length: eventProvider.eventNameList.length,
                  child: TabBar(
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      labelPadding: EdgeInsets.symmetric(horizontal: width*0.01),
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      onTap: (index) {
                        setState(() {
                          eventProvider.changeSelectIndex(index,userProvider.currentUser!.id);
                        });
                      },
                      tabs: eventProvider.eventNameList
                          .asMap()
                          .entries
                          .map((entry) {
                        return DefualtControler(
                          text: entry.value,
                          isSelected: eventProvider.selectIndex == entry.key,
                        );
                      }).toList()
                  )
              )

            ],
          ),
        ),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back',style:TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),),
                Text(userProvider.currentUser!.name,style: AppTextStyle.bold24White,),

              ],
            ),
            Spacer(),
            InkWell(onTap: () {

            },
                child: ImageIcon( themeProvider == ThemeMode.light ?
                    AssetImage(AppAssets.moon)
                    :AssetImage(AppAssets.sun)
                )
            ),
            SizedBox(width: width*0.01,),
            InkWell(
              onTap: () {

              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width*0.02,
                  vertical: height*0.01
                ),
                child: Text('En',style: AppTextStyle.bold16Primary,),
                decoration: BoxDecoration(
                  color: AppColors.whiteBgColor,
                  borderRadius: BorderRadiusGeometry.circular(10)
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child:
              eventProvider.filterEventList.isEmpty ?
              Center(
                child: Text('No Event founds', style: themeProvider.isDarkMode ?
                AppTextStyle.bold20White : AppTextStyle.bold20Black
                  ,),) :
              ListView.separated(
                padding: EdgeInsets.symmetric(
                  vertical: height*0.02
                ),
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          final provider = Provider.of<EventListProvider>(context, listen: false);
                          provider.setSelectedEvent(provider.filterEventList[index]);
                          Navigator.pushNamed(context, AppRoutes.eventDetails
                          );
                        },
                        child: ItemBuiltForListView(
                          event: eventProvider.filterEventList[index],));
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height*0.01,);
                  },
                  itemCount: eventProvider.filterEventList.length))
        ],
      ),
    );
  }

}


