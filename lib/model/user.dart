import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String photoUrl;
  final String uid;
  final String email;
  final String bio;
  final List followers;
  final List following;

  User({
    required this.email,
    required this.uid,
    required this.username,
    required this.photoUrl,
    required this.bio,
    required this.followers,
    required this.following,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'username': username,
        'photoUrl': photoUrl,
        'bio': bio,
        'followers': followers,
        'following': following,
      };
}
