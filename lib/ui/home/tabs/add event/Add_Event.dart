import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled/model/Event.dart';
import 'package:untitled/provider/user%20provider.dart';
import 'package:untitled/ui/loop%20widgets/Custom_Text_Form.dart';
import 'package:untitled/uitels/AppAssets.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppTextStyle.dart';
import 'package:untitled/uitels/firebaseuitles.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../model/my user.dart';
import '../../../../provider/App_theme_Provider.dart';
import '../../../../provider/event list provider.dart';

class Addinv extends StatefulWidget {
   Addinv({super.key});

  @override
  State<Addinv> createState() => _AddinvState();
}

class _AddinvState extends State<Addinv> {
  bool isDateValid = true;
  bool isTimeValid = true;

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descrbtionEditingController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  int selectIndex = 0;
  DateTime? selctedDate;
  TimeOfDay? selctedTime;
  String selctedEventName = '';
  String selctedEventImage = '';
  String formatDate = '';
  String formatTime = '';
  late EventListProvider eventProvider;
  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventListProvider>(context);

    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    List<String> eventsName = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.work_shop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,

    ];
    List<String> imagesEvent = [
      AppAssets.sportBackGround,
      AppAssets.birthdayBackGround,
      AppAssets.meetingBackGround,
      AppAssets.gamingBackGround,
      AppAssets.workShopBackGround,
      AppAssets.bookClubBackGround,
      AppAssets.exhiditionBackGround,
      AppAssets.holidayBackGround,
      AppAssets.eatingBackGround,
    ];
    selctedEventName = eventsName[selectIndex];
    selctedEventImage = imagesEvent[selectIndex];

    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            }, child: Icon(Icons.arrow_back, color: AppColors.primaryColor,),
          ),
          title: Text('Creat Event', style: AppTextStyle.bold20Primary,),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(selctedEventImage),
                            fit: BoxFit.fill)
                    ),
                  ),
                  SizedBox(height: height * 0.01,),
                  SizedBox(
                    height: height * 0.04,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              selectIndex = index;
                              setState(() {

                              });
                            },
                            child: DefualtControler1(
                              text: eventsName[index],
                              isSelected: selectIndex == index,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: width * 0.01,);
                        },
                        itemCount: eventsName.length),
                  ),

                  Form(
                      key: formKey,
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: Theme
                                .of(context)!
                                .textTheme
                                .headlineLarge,
                          ),
                          SizedBox(height: height * 0.01,),
                          CustomTextForm(
                            textStyle: themeProvider.isDarkMode
                                ? AppTextStyle.normal16White
                                : AppTextStyle.normal16Black,
                            colorBorderSide: themeProvider.isDarkMode
                                ? AppColors.primaryColor : AppColors.greyColor,
                            validator: (text) {
                              if (text == null || text
                                  .trim()
                                  .isEmpty) {
                                return 'Pleas enter title';
                              }
                              return null;
                            },
                            controller: titleEditingController,
                            hintText: 'ride details title',

                          ),
                          Text(
                            'Describtion',
                            style: Theme
                                .of(context)!
                                .textTheme
                                .headlineLarge,
                          ),
                          SizedBox(height: height * 0.01,),
                          CustomTextForm(
                            textStyle: themeProvider.isDarkMode
                                ? AppTextStyle.normal16White
                                : AppTextStyle.normal16Black,
                            colorBorderSide: themeProvider.isDarkMode
                                ? AppColors.primaryColor : AppColors.greyColor,
                            validator: (text) {
                              if (text == null || text
                                  .trim()
                                  .isEmpty) {
                                return 'Pleas enter describtion';
                              }
                              return null;
                            },
                            controller: descrbtionEditingController,
                            hintText: 'ride details pleas',
                            maxlin: 5,
                          ),


                          SizedBox(height: height * 0.01,),

                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined),
                              Text("Event Date", style: Theme
                                  .of(context)!
                                  .textTheme
                                  .headlineLarge),
                              Spacer(),
                              TextButton(
                                onPressed: chooseDate,
                                child: Text(
                                  selctedDate == null
                                      ? 'choose date'
                                      : formatDate,
                                  style: selctedDate == null
                                      ? AppTextStyle.bold16Primary
                                      : AppTextStyle.bold16Primary,
                                ),
                              ),
                            ],
                          ),
                          if (!isDateValid)
                            Text(
                              'Please select a date',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          SizedBox(height: height * 0.01),

// For Time
                          Row(
                            children: [
                              Icon(Icons.access_time),
                              Text('Event time', style: Theme
                                  .of(context)!
                                  .textTheme
                                  .headlineLarge),
                              Spacer(),
                              TextButton(
                                onPressed: chooseTime,
                                child: Text(
                                  selctedTime == null
                                      ? 'choose time'
                                      : formatTime,
                                  style: selctedTime == null
                                      ? AppTextStyle.bold16Primary
                                      : AppTextStyle.bold16Primary,
                                ),
                              ),
                            ],
                          ),
                          if (!isTimeValid)
                            Text(
                              'Please select a time',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          SizedBox(height: height * 0.01,),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.primaryColor
                                  )
                              ),
                              child: FloatingActionButton(
                                backgroundColor: AppColors.whiteBgColor,
                                onPressed: () {

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: width * 0.01
                                      ),
                                      height: height * 0.05,
                                      width: width * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              8),
                                          color: AppColors.primaryColor
                                      ),
                                      child: Icon(Icons.my_location_rounded,
                                        color: AppColors.whiteBgColor,),
                                    ),
                                    SizedBox(width: width * 0.01,),
                                    Text('Cairo , Egypt',
                                      style: AppTextStyle.bold20Primary,),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios_sharp,
                                      color: AppColors.primaryColor,)

                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.02,),

                          SizedBox(
                            width: double.infinity,
                            child: FloatingActionButton(
                              backgroundColor: AppColors.primaryColor,
                              onPressed: () {
                                addEvent();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Add event',
                                    style: AppTextStyle.bold20White,),

                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  )


                ],
              ),
            ),
          ),
        )
    );
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }


  void addEvent() {
    setState(() {
      isDateValid = selctedDate != null;
      isTimeValid = selctedTime != null;
    });

    if (formKey.currentState?.validate() == true && isDateValid &&
        isTimeValid) {


    }

 var userProvider = Provider.of<UserProvider>(context,listen: false);
    var event = Event(
        eventImage: selctedEventImage,
        eventDateTime: selctedDate!,
        eventDesc: descrbtionEditingController.text,
        eventName: selctedEventName,
        eventTime: formatTime,
        eventTitle: titleEditingController.text);
    FirebaseLogic.addEventToFireBase(event,userProvider.currentUser!.id).then((value) {
      Fluttertoast.showToast(
          msg: "Event add sucessfuly",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16);
      eventProvider.getAllEvents(userProvider.currentUser!.id);
    },)
        .timeout(
      Duration(milliseconds: 500),
      onTimeout: () {
        Fluttertoast.showToast(
            msg: "Event add sucessfuly",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryColor,
            textColor: Colors.white,
            fontSize: 16);

        eventProvider.getAllEvents(userProvider.currentUser!.id);
      },

    );
    Navigator.pop(context);
  }


  void chooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selctedDate = chooseDate;
    if (selctedDate != null) {
      formatDate = DateFormat('dd/MM/yyyy').format(selctedDate!);
    }
    setState(() {

    });
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    selctedTime = chooseTime;
    if (selctedTime != null) {
      formatTime = selctedTime!.format(context);
      setState(() {

      });
    }
  }


//   void addEvent(){
//   if(formKey.currentState?.validate()==true){
//    return Navigator.of(context)!.pop();
//   }
//   }
}


class DefualtControler1 extends StatelessWidget {
  const DefualtControler1({
    Key? key,
    required this.isSelected,
    required this.text,
  }) : super(key: key);

  final bool isSelected;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1,
        ),
        color: isSelected
            ? AppColors.primaryColor
            : Colors.transparent,
      ),
      child: Text(
        text,
        style: isSelected
            ? AppTextStyle.bold20White
            : AppTextStyle.bold20Primary,
      ),
    );
  }
}

