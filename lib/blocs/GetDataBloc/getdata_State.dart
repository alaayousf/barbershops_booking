import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GetDataState extends Equatable {
 

  @override
  List<Object> get props => [];
}

class GetALLInitial extends GetDataState {}



class ResevALLBarbers extends GetDataState {

  final  List<QueryDocumentSnapshot<Map<String, dynamic>>> barbers;

  ResevALLBarbers(this.barbers);
}

class ResevALLServis extends GetDataState {

  final  List<QueryDocumentSnapshot<Map<String, dynamic>>> datas;

  ResevALLServis(this.datas);
}

class LodingGertSevic extends GetDataState {}


class Loding extends GetDataState {}
class Success extends GetDataState {}
class Filde extends GetDataState {}




class LodingSaech extends GetDataState {}





class GetMyReservationState extends GetDataState {

  QueryDocumentSnapshot<Map<String, dynamic>> myReservationState;

  GetMyReservationState(this.myReservationState);

}


class NOGetMyReservationState extends GetDataState {}


class DeleteState extends GetDataState {}



//لي ارجاع الكود لي عملية البحت
class SearchState extends GetDataState {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> barbers;

  LatLng position;

  SearchState(this.barbers,this.position);


}





class ResevOneberberReservation extends GetDataState {

  final  List<QueryDocumentSnapshot<Object?>> datas;
  

  ResevOneberberReservation(this.datas);

  
}




