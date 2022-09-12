import 'package:flutter_modular/flutter_modular.dart';
import 'package:pneumonia_flutter/app/modules/home/domain/usecases/predict_image_file_usecase.dart';
import 'package:pneumonia_flutter/app/modules/home/external/http/http_predict_image_file.dart';
import 'package:pneumonia_flutter/app/modules/home/infra/repositories/predict_image_file_repository_impl.dart';
import 'package:pneumonia_flutter/app/modules/home/presenter/home_page.dart';
import 'package:pneumonia_flutter/app/modules/home/presenter/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [

    //Predict Image File Usecase
    Bind.lazySingleton((i) => HttpPredictImageFile()),
    Bind.lazySingleton((i) => PredictImageFileRepositoryImpl(i())),
    Bind.lazySingleton((i) => PredictImageFileUsecase(i())),
    //Store
    Bind.lazySingleton((i) => HomeStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];
}
