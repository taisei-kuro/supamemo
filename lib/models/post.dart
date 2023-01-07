import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Timestamp createdAt;
  DocumentReference postRef;
  String imageUrl;
  String name;
  String content;

  Post({
    required this.createdAt,
    required this.postRef,
    required this.imageUrl,
    required this.name,
    required this.content,
  });

  factory Post.fromMap(Map<String, dynamic> data) => Post(
        createdAt: data['createdAt'],
        postRef: data['postRef'],
        imageUrl: data['imageUrl'],
        name: data['name'],
        content: data['content'],
      );

  factory Post.initialData() => Post(
        createdAt: Timestamp.now(),
        postRef: FirebaseFirestore.instance.collection('posts').doc(),
        imageUrl: '',
        name: '',
        content: '',
      );

  Map<String, dynamic> toMap() => {
        'createdAt': createdAt,
        'postRef': postRef,
        'imageUrl': imageUrl,
        'title': name,
        'content': content,
      };
}
