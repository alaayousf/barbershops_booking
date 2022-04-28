import 'package:equatable/equatable.dart';

abstract class GetDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetALLBarbers extends GetDataEvent {}







class GetALLServeis extends GetDataEvent {}


class SarchEvetn extends GetDataEvent {
  String sarshKey;
  SarchEvetn(this.sarshKey);
}






class GetOneServeis extends GetDataEvent {
  String id;
  DateTime time;
  GetOneServeis(this.id,this.time);

}



class GetMyReservation extends GetDataEvent {
  String iDPerson;
  GetMyReservation(this.iDPerson);

}



//delete MY reservation
class DeleteMyReservation extends GetDataEvent {
  String iDPerson;
  DeleteMyReservation(this.iDPerson);
}




class AddNewReservation extends GetDataEvent {
 String iDPerson;
  String iDberBer;
  DateTime day;

  AddNewReservation(this.iDPerson,this.iDberBer,this.day);

}






