import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelctedProvider extends ChangeNotifier{
  int indexs;
  QueryDocumentSnapshot<Map<String, dynamic>>? servic;

SelctedProvider(this.indexs);

void setArray(int value,  QueryDocumentSnapshot<Map<String, dynamic>> sernew) {
  indexs=value;
  servic=sernew;
  notifyListeners();
}






 


    

  
}