import 'dart:typed_data';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morningstar/core/data/upload_images_service.dart';

import '../../mock.dart';

void main() {
  const tUrl = 'https://cloudinary.com/image.png';
  late MockXFile mockFile;
  late MockCloudinary mockCloudinary;
  late UploadImagesService uploadImagesService;

  setUp(() {
    mockFile = MockXFile();
    mockCloudinary = MockCloudinary();
    uploadImagesService = UploadImagesService(cloudinary: mockCloudinary);

    when(() => mockFile.path).thenReturn('image.png');
    when(() => mockFile.readAsBytes()).thenAnswer((_) async => Uint8List(2));
  });

  test('Should answer with resource url when request is successful', () async {
    when(() => mockCloudinary.unsignedUpload(
          uploadPreset: any(named: 'uploadPreset'),
          file: any(named: 'file'),
          folder: any(named: 'folder'),
          fileName: any(named: 'file'),
          fileBytes: any(named: 'fileBytes'),
          resourceType: any(named: 'resourceType'),
        )).thenAnswer((_) async => CloudinaryResponse(secureUrl: tUrl));

    final result = await uploadImagesService.uploadImage(mockFile);

    expect(result, tUrl);
    verify(() => mockCloudinary.unsignedUpload(
          uploadPreset: any(named: 'uploadPreset'),
          file: any(named: 'file'),
          folder: any(named: 'folder'),
          fileName: any(named: 'file'),
          fileBytes: any(named: 'fileBytes'),
          resourceType: any(named: 'resourceType'),
        ));
    verifyNoMoreInteractions(mockCloudinary);
  });

  // TODO: Write error tests
}
