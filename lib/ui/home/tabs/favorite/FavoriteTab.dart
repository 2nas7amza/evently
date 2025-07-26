import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/App_theme_Provider.dart';
import 'package:untitled/ui/loop%20widgets/Custom_Text_Form.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppTextStyle.dart';

import '../../../../provider/event list provider.dart';
import '../../../../provider/user provider.dart';
import '../home/Item_Built_For_ListVeiw.dart';

class FavoriteTab extends StatefulWidget {
  FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late EventListProvider eventProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      eventProvider.getFavList(userProvider.currentUser!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventListProvider>(context);
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(

          children: [
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: CustomTextForm(
                prefixIcon: Icon(Icons.search,color: AppColors.primaryColor,),
                colorHintStyle: AppColors.primaryColor,
                colorBorderSide: AppColors.primaryColor,
                hintText: 'Search for events',

              ),
            ),
            SizedBox(height: height*0.01,),
            Expanded(
                child:
                eventProvider.getFavEvent.isEmpty ?
                Center(child: Text('No Favorit Event found.',
                  style: themeProvider.isDarkMode ?
                  AppTextStyle.bold20White : AppTextStyle.bold20Black,
                ),) :
                ListView.separated(
                    padding: EdgeInsets.symmetric(
                        vertical: height*0.02
                    ),
                    itemBuilder: (context, index) {
                      return ItemBuiltForListView(
                          event: eventProvider.getFavEvent[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height*0.01,);
                    },
                    itemCount: eventProvider.getFavEvent.length))
          ],
        ),
      ),
    );
  }
}
