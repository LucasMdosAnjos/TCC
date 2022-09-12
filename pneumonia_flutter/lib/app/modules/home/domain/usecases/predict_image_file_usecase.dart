import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pneumonia_flutter/app/modules/home/domain/entity/predict_result.dart';

import '../entity/params_predict_image_file.dart';
import '../errors/errors.dart';
import '../repositories/predict_image_file_repository.dart';

abstract class IPredictImageFileUsecase {
  Future<Either<PredictImageFileException, PredictResult>> call(ParamsPredictImageFile params);
}

class PredictImageFileUsecase implements IPredictImageFileUsecase {
  final PredictImageFileRepository predictImageFileRepository;

  PredictImageFileUsecase(this.predictImageFileRepository);
  @override
  Future<Either<PredictImageFileException, PredictResult>> call(
      ParamsPredictImageFile params) async {
    return await predictImageFileRepository.predictImageFile(params);
  }
}
