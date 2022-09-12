import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pneumonia_flutter/app/modules/home/domain/entity/params_predict_image_file.dart';
import 'package:pneumonia_flutter/app/modules/home/domain/errors/errors.dart';

import '../entity/predict_result.dart';

abstract class PredictImageFileRepository{
  Future<Either<PredictImageFileException,PredictResult>> predictImageFile(ParamsPredictImageFile params);
}