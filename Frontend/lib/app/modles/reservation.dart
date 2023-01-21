class Reservation {
  int reservation;
  int id;
  String userId;
  String vehicleId;
  int slotId;
  Reservation(this.userId, this.reservation, this.id, this.vehicleId, this.slotId);
}

class Slot{
  //String slotDescription;
 // String sensorState;
  String id;
  String state;
  Slot(this.id, this.state);
}




