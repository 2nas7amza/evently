import 'package:flutter/material.dart';

class Event {
  static const String colloctionName = 'Event';
  String id;
  String eventImage;
  String eventName;
  String eventTitle;
  String eventDesc;
  DateTime eventDateTime;
  String eventTime;
  bool isFavorite;

  Event({
    this.id = '',
    this.isFavorite = false,
    required this.eventImage,
    required this.eventDateTime,
    required this.eventDesc,
    required this.eventName,
    required this.eventTime,
    required this.eventTitle,
  });

  Event.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data["id"],
        eventImage: data["event_image"],
        eventName: data["event_name"],
        eventTitle: data["event_title"],
        eventDesc: data["event_desc"],
        eventDateTime: DateTime.fromMillisecondsSinceEpoch(
          data["event_date_time"],
        ),
        eventTime: data["even_time"],
        isFavorite: data["is_favorite"],
      );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "event_image": eventImage,
      "event_name": eventName,
      "event_title": eventTitle,
      "event_desc": eventDesc,
      "event_date_time": eventDateTime.millisecondsSinceEpoch,
      "even_time": eventTime,
      "is_favorite": isFavorite,
    };
  }



}
