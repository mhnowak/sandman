import 'package:cloudinary/cloudinary.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagesService {
  UploadImagesService({
    required Cloudinary cloudinary,
  }) : _cloudinary = cloudinary;

  final Cloudinary _cloudinary;

  Future<String> uploadImage(XFile file) async {
    final result = await _cloudinary.unsignedUpload(
      uploadPreset: 'q8k7sksk',
      folder: 'public',
      file: file.path,
      fileBytes: await file.readAsBytes(),
      resourceType: CloudinaryResourceType.image,
    );

    return result.secureUrl!;
  }
}
