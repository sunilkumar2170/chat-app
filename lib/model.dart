class Model {
  String? uid;
  String? fullname;
  String? email;
  String? profilepic;

  // Constructor
  Model({this.uid, this.fullname, this.email, this.profilepic});

  // fromMap factory constructor to create an instance from a map
  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      uid: map['uid'],
      fullname: map['full'],
      email: map['email'],
      profilepic: map['profilepic'],
    );
  }

  // Optional: toMap method to convert an instance back to a map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'full': fullname,
      'email': email,
      'profilepic': profilepic,
    };
  }
}