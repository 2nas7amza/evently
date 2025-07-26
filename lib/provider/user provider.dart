import 'package:flutter/material.dart';
import 'package:untitled/model/my%20user.dart';

class UserProvider extends ChangeNotifier{
  MyUser? currentUser;


  void updateUser(MyUser user){
    currentUser=user;
    notifyListeners();
  }

}