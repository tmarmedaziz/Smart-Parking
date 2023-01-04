class AvailableSlots {

  final String slotname;
  final int availability;
  final String id;

  AvailableSlots({

    required this.slotname,
    required this.availability,
    required this.id,
  });

  factory AvailableSlots.fromJson(Map<String, dynamic> json) {
    return AvailableSlots(
      slotname: json.containsKey("message")
          ? json["message"].containsKey("slotname")
              ? json["message"]["username"]
              : ""
          : "",
      availability: json.containsKey("message")
          ? json["message"].containsKey("availability")
              ? json["message"]["availability"]
              : -1
          : -1,
      id: json.containsKey("message")
          ? json["message"].containsKey("id")
              ? json["message"]["id"]
              : ""
          : "",
    );
  }
}
