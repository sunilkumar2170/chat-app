class MessageModel {
  String sender;
  String text;
  bool seen;
  DateTime createdOn;

  // Constructor
  MessageModel({
    required this.sender,
    required this.text,
    required this.seen,
    required this.createdOn,
  });

  // Factory constructor to create an instance from a map
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      sender: map['sender'] as String,
      text: map['text'] as String,
      seen: map['seen'] as bool,
      // Agar createdOn string form me hai to DateTime.parse ka use karo
      createdOn: map['createdOn'] is String
          ? DateTime.parse(map['createdOn'])
          : map['createdOn'] as DateTime,
    );
  }

  // Method to convert instance to map
  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'text': text,
      'seen': seen,
      'createdOn': createdOn.toIso8601String(),
    };
  }
}
