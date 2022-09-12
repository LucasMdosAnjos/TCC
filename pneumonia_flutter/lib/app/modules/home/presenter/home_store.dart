import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:pneumonia_flutter/app/modules/home/domain/entity/params_predict_image_file.dart';
import 'package:pneumonia_flutter/app/modules/home/domain/entity/predict_result.dart';
import 'package:pneumonia_flutter/app/modules/home/domain/errors/errors.dart';
import 'package:pneumonia_flutter/app/modules/home/domain/usecases/predict_image_file_usecase.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final PredictImageFileUsecase predictImageFileUsecase;

  HomeStoreBase(this.predictImageFileUsecase);
  @observable
  int counter = 0;

  Future<void> increment() async {
    counter = counter + 1;
  }

  getImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setSelectedImage(result.files.first);
    } else {
      // User canceled the picker
    }
  }

  @observable
  PlatformFile? selectedImage;

  @observable
  PredictResult? predictResult;

  @observable
  bool salvando = false;

  @action
  setSelectedImage(PlatformFile file) async {
    selectedImage = file;
    predictResult = null;
    salvando = true;
    final result = await predictImageFileUsecase(ParamsPredictImageFile(
        bytesFile: selectedImage!.bytes!,
        nome_arquivo: selectedImage!.name,
        extensao: selectedImage!.extension!));
    result.fold(errorPredictImageFile, setPredictResult);
  }

  @action
  setPredictResult(PredictResult value) {
    salvando = false;
    predictResult = value;
  }

  errorPredictImageFile(PredictImageFileException exception) {
    print(exception);
    salvando = false;
  }
}
