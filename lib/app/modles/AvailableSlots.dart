class AvailableSlots {

  final String slotusername;
  final int availability;
  final String id;

  AvailableSlots({

    required this.slotusername,
    required this.availability,
    required this.id,
  });

  factory AvailableSlots.fromJson(Map<String, dynamic> json) {
    return AvailableSlots(
      slotusername: json.containsKey("message")
          ? json["message"].containsKey("username")
              ? json["message"]["username"]
              : ""
          : "",
      availability: json.containsKey("message")
          ? json["message"].containsKey("permissions")
              ? json["message"]["permissions"]
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
