import 'package:image_picker/image_picker.dart';

abstract class ImagePickerUtils {
  Future<String> selectImageFromCamera();
}

class ImagePickerUtilsImpl extends ImagePickerUtils {
  @override
  Future<String> selectImageFromCamera() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, maxHeight: 1024, maxWidth: 1024);
      if (image != null) {
        return image.path;
      } else {
        return '';
      }
    } catch (ex) {
      return '';
    }
  }
}
