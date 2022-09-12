import 'package:flutter/foundation.dart';

import '../../domain/entity/params_predict_image_file.dart';
import '../../domain/entity/predict_result.dart';

abstract class PredictImageFileDatasource{
  Future<PredictResult> predictImageFile(ParamsPredictImageFile params);
}