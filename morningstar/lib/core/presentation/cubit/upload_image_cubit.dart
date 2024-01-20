import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morningstar/core/data/upload_images_service.dart';
import 'package:morningstar/core/domain/exceptions/unknown_exception.dart';
import 'package:morningstar/core/domain/state/data_state.dart';

class UploadImageCubit extends Cubit<DataState<String>> {
  UploadImageCubit(this._imagesService) : super(const DataState.idle());

  final UploadImagesService _imagesService;

  Future<void> uploadFile(XFile file) async {
    emit(const DataState.loading());
    try {
      final result = await _imagesService.uploadImage(file);
      emit(DataState.loaded(result));
    } catch (e) {
      emit(DataState.exception(UnknownException(e)));
    }
  }

  void setInitialUrl(String initialUrl) {
    emit(DataState.loaded(initialUrl));
  }
}
