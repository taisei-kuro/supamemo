import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filePickerServiceProvider = Provider(
  (ref) => FilePickerService(),
);

class FilePickerService {
  /// 複数のファイルを端末から取得してList型で[PlatformFile]を返す
  // Future<List<PlatformFile>> get pickMultipleFiles async {
  //   final result = await FilePickerWeb.platform.pickFiles(allowMultiple: true);
  //   if (result != null) {
  //     return result.files;
  //   } else {
  //     throw Exception('Unable to read the file');
  //   }
  // }

  /// 単一のファイルを端末から取得して[PlatformFile]を返す
  Future<PlatformFile> get pickSingleFile async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result.files.first;
    } else {
      throw Exception('Unable to read the file');
    }
  }

  /// 特定の種類のファイルの拡張子を入力して、[PlatformFile]を返す。
  ///
  /// 例：selectFileExtension(e.g. ['pdf', 'svg', 'jpg']);
  Future<PlatformFile> selectFileExtension(
      List<String> allowedExtensions) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (result != null) {
      return result.files.first;
    } else {
      throw Exception('Unable to read the file');
    }
  }
}
