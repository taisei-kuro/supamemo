import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageServiceProvider =
    Provider<FirebaseStorageService>((ref) => FirebaseStorageService());

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> upload(PlatformFile file) async {
    final storageRef = _firebaseStorage.ref().child(file.name);
    UploadTask uploadTask;
    try {
      // XFileからUint8Listへ変換してCloudStorageへアップロード
      uploadTask = storageRef.putData(file.bytes!);
      final snapshot = await Future.value(uploadTask);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return e.toString();
    }
  }

  /// file_pickerによって取得した[PlatformFile]をFirebaseStorageにアップロードし、downloadURLを返す。
  Future<String> uploadPlatformFile(
      String path, PlatformFile platformFile) async {
    final storageRef = _firebaseStorage.ref().child(path);
    final bytes = platformFile.bytes;
    if (bytes == null) {
      throw Exception('Unable to read the file');
    }

    UploadTask uploadTask;
    try {
      // XFileからUint8Listへ変換してCloudStorageへアップロード
      uploadTask = storageRef.putData(bytes);
      final snapshot = await Future.value(uploadTask);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return e.toString();
    }
  }
}
