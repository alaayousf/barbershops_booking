import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListTimeProvider extends ChangeNotifier{
  DateTime indexs;

    

  

ListTimeProvider(this.indexs);

void setListTime(DateTime value) {
  indexs=value;
  notifyListeners();
}






 


    

  
}