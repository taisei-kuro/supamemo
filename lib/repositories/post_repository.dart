import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supamemo/models/post.dart';
import 'package:supamemo/services/file_picker_service.dart';
import 'package:supamemo/services/firebase_storage_service.dart';

final PostRepositoryProvider =
    ChangeNotifierProvider.autoDispose<PostRepository>(
  (ref) => PostRepository(
    ref.watch(filePickerServiceProvider),
    ref.watch(firebaseStorageServiceProvider),
  ),
);

class PostRepository extends ChangeNotifier {
  PostRepository(
    this._filePickerService,
    this._firebaseStorageService,
  );

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FilePickerService _filePickerService;
  final FirebaseStorageService _firebaseStorageService;

  Post newPost = Post.initialData();
  Post updatedPost = Post.initialData();
  bool isLoading = false;
  String errorTextForUploadImage = '';
  String errorTextForYoutubeUrl = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  File? imageFile;
  final picker = ImagePicker();

  bool get isPostEdited {
    if (updatedPost.imageUrl.isEmpty &&
        updatedPost.name.isEmpty &&
        updatedPost.content.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> addPostData() async {
    await uploadImage();
    newPost.postRef = _firebaseFirestore.collection('posts').doc();
    await newPost.postRef.set(newPost.toMap());
  }

  Future<void> updatePost(Post selectedPost) async {
    if (updatedPost.imageUrl.isEmpty) {
      updatedPost.imageUrl = selectedPost.imageUrl;
    }
    if (updatedPost.name.isEmpty) {
      updatedPost.name = selectedPost.name;
    }
    if (updatedPost.content.isEmpty) {
      updatedPost.content = selectedPost.content;
    }
    updatedPost.postRef = selectedPost.postRef;
    updatedPost.createdAt = selectedPost.createdAt;
    await selectedPost.postRef.update(updatedPost.toMap());
  }

  /// image_pickerでデバイス内の画像ファイルをpickしてCloud Storageにアップロード
  Future<void> uploadImage() async {
    final doc = FirebaseFirestore.instance.collection('posts').doc();
    String? imgURL;
    if (imageFile != null) {
      // storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('posts/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
      newPost.imageUrl = imgURL;
    }
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Query<Post> get PostQuery =>
      _firebaseFirestore.collection('posts').orderBy('createdAt').withConverter(
            fromFirestore: (snapshot, _) => Post.fromMap(snapshot.data()!),
            toFirestore: (Post, _) => Post.toMap(),
          );

  void inputPostName(String text) {
    newPost.name = text;
    notifyListeners();
  }

  void updatePostName(String text) {
    updatedPost.name = text;
    notifyListeners();
  }

  void inputPostContent(String text) {
    newPost.content = text;
    notifyListeners();
  }

  void updatePostContent(String text) {
    updatedPost.content = text;
    notifyListeners();
  }

  void _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _endLoading() {
    isLoading = false;
    notifyListeners();
  }
}
