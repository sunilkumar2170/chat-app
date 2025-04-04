class Chatroom {
  String? chatroomid;
  List<String>? part;

  // Constructor
  Chatroom({this.chatroomid, this.part});

  // Factory constructor to create an instance from a map
  factory Chatroom.fromMap(Map<String, dynamic> map) {
    return Chatroom(
      chatroomid: map['chatroomid'],
      part: map['part'] != null ? List<String>.from(map['part']) : null,
    );
  }

  // Optional: toMap method to convert an instance back to a map
  Map<String, dynamic> toMap() {
    return {
      'chatroomid': chatroomid,
      'part': part,
    };
  }
}
