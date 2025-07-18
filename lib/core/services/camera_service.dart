import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked == null) return null;
    return File(picked.path);
  }
}
