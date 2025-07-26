import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/model/Event.dart';
import 'package:untitled/model/my%20user.dart';

class FirebaseLogic {
  static CollectionReference<Event> getEventCollctinos(String uid) {
    return getUserCollction().doc(uid)
        .collection(Event.colloctionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }
  static CollectionReference<MyUser> getUserCollction(){
    return FirebaseFirestore.instance.collection(MyUser.collocName).withConverter(
        fromFirestore: (snapshot, options) =>MyUser.fromFireStore(snapshot.data()!) ,
        toFirestore: (myUser, options) =>myUser.toFireStore(),);
  }
  static Future<void> adduserToFireBase(MyUser myUser){
    return getUserCollction().doc(myUser.id).set(myUser);
  }

  static Future<void> addEventToFireBase(Event event,String uid) {
    var collec = getEventCollctinos(uid);
    var docref = collec.doc();
    event.id = docref.id;
    return docref.set(event);
  }

  static Future<MyUser?> readUserFromFireStore(String id)async{
     var querySnapshot =    await getUserCollction().doc(id).get();
     return querySnapshot.data();
  }
  static Future<void> deleteEventFromFirestore(String uid, String eventId) async {
    var eventCollection = getEventCollctinos(uid);
    await eventCollection.doc(eventId).delete();
  }


}




