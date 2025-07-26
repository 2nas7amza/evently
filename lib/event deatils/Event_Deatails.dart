import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../model/Event.dart';
import '../provider/App_theme_Provider.dart';
import '../provider/event list provider.dart';
import '../provider/user provider.dart';
import '../uitels/AppAssets.dart';
import '../uitels/AppColors.dart';
import '../uitels/AppRoutes.dart';
import '../uitels/AppTextStyle.dart';

class Ed extends StatelessWidget {
  const Ed({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventListProvider>();
    final event = eventProvider.selectedEvent;
    final userId = Provider.of<UserProvider>(context).currentUser!.id;
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final size = MediaQuery.of(context).size;

    if (eventProvider.selectedEvent != null) {
      eventProvider.refreshSelectedEvent(userId, eventProvider.selectedEvent!.id);
    }

    if (event == null) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: AppColors.primaryColor),
        ),
        body: Center(child: Text('No event selected')),
      );
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(color: AppColors.primaryColor),
        title: Text('Event Details', style: AppTextStyle.bold20Primary),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: AppColors.primaryColor),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.eventEdit),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await eventProvider.deleteEvent(userId, event.id);
              Fluttertoast.showToast(msg: '✅ Event deleted');
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: _buildEventDetailsBody(event, themeProvider, size),
      ),
    );
  }

  Widget _buildEventDetailsBody(Event event, AppThemeProvider themeProvider, Size size) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventImage(size.height, event),
          SizedBox(height: size.height * 0.02),
          Text(event.eventTitle, style: AppTextStyle.bold24Primary),
          SizedBox(height: size.height * 0.02),
          _buildLocationCard(event, size),
          SizedBox(height: size.height * 0.02),
          _buildDateTimeCard(event, themeProvider, size),
          SizedBox(height: size.height * 0.02),
          _buildMapImage(size.height),
          SizedBox(height: size.height * 0.02),
          _buildDescriptionSection(event, themeProvider),
        ],
      ),
    );
  }

  Widget _buildEventImage(double height, Event event) {
    return Container(
      height: height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(event.eventImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLocationCard(Event event, Size size) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on, color: AppColors.primaryColor),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Text('Cairo', style: AppTextStyle.bold20Primary),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeCard(Event event, AppThemeProvider themeProvider, Size size) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: AppColors.primaryColor),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${event.eventDateTime.day} / ${DateFormat('MMM').format(event.eventDateTime)} / ${event.eventDateTime.year}',
                  style: AppTextStyle.bold20Primary,
                ),
                Text(
                  event.eventTime ?? 'Time not specified',
                  style: themeProvider.isDarkMode
                      ? AppTextStyle.bold16White
                      : AppTextStyle.bold16Black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapImage(double height) {
    return Container(
      height: height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(AppAssets.mapImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(Event event, AppThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description',
            style: themeProvider.isDarkMode
                ? AppTextStyle.bold16White
                : AppTextStyle.bold16Black),
        SizedBox(height: 8),
        Text(
          event.eventDesc ?? 'No description available',
          style: themeProvider.isDarkMode
              ? AppTextStyle.bold20White
              : AppTextStyle.bold20Black,
        ),
      ],
    );
  }
}
