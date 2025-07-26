import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/user%20provider.dart';

import '../l10n/app_localizations.dart';
import '../model/Event.dart';
import '../uitels/AppColors.dart';
import '../uitels/firebaseuitles.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> filterEventList = [];
  List<String> eventNameList = [];
  List<Event> getFavEvent = [];
  int selectIndex = 0;



  List<String> getEventNameList(BuildContext context) {
    return eventNameList = [
      AppLocalizations.of(context)!.all,
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
  }
  Event? _selectedEvent;

  Event? get selectedEvent => _selectedEvent;

  void setSelectedEvent(Event event) {
    _selectedEvent = event;
    notifyListeners();
  }
  void getAllEvents(String uid) async {
    QuerySnapshot<Event> querySnspshot =
    await FirebaseLogic.getEventCollctinos(uid).get();
    eventList = querySnspshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterEventList = eventList;
    notifyListeners();
  }

  void getFilterEvents(String uid) async {
    var querySnap = await FirebaseLogic.getEventCollctinos( uid).get();
    eventList = querySnap.docs.map((doc) {
      return doc.data();
    }).toList();

    filterEventList = eventList.where((event) {
      return event.eventName == eventNameList[selectIndex];
    }).toList();

    notifyListeners();
  }

  void upDateThisFav(Event event,String uid) {
    FirebaseLogic.getEventCollctinos( uid)
        .doc(event.id)
        .update({"is_favorite": !event.isFavorite})
        .timeout(
      Duration(milliseconds: 500),
      onTimeout: () {
        Fluttertoast.showToast(
          msg: "Event updated succesfuly. ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          fontSize: 16,
        );
      },
    );
    selectIndex == 0 ? getAllEvents(uid) : getFilterEvents(uid);
    getFavList(uid);
    notifyListeners();
  }

  void getFavList(String uid) async {
    var querySnap = await FirebaseLogic.getEventCollctinos( uid).get();

    eventList = querySnap.docs.map((doc) {
      return doc.data();
    }).toList();

    getFavEvent = eventList.where((event) {
      return event.isFavorite == true;
    }).toList();
    notifyListeners();
  }

  void changeSelectIndex(int newSelectIndex,String uid) {
    selectIndex = newSelectIndex;
    selectIndex == 0 ? getAllEvents(uid) : getFilterEvents(uid);
  }
  Future<void> deleteEvent(String uid, String eventId) async {
    await FirebaseLogic.deleteEventFromFirestore(uid, eventId);
    eventList.removeWhere((e) => e.id == eventId);
    filterEventList.removeWhere((e) => e.id == eventId);
    getFavEvent.removeWhere((e) => e.id == eventId);
    notifyListeners();
  }
  Future<void> refreshSelectedEvent(String uid, String eventId) async {
    var doc = await FirebaseLogic.getEventCollctinos(uid).doc(eventId).get();
    if (doc.exists) {
      setSelectedEvent(doc.data()!);
    }
  }

}