import 'package:pneumonia_flutter/app/modules/home/domain/entity/predict_result.dart';

class PredictResultMapper {
  static PredictResult fronJson(Map data) {
    return PredictResult(
        confidence: data['confidence'],
        lime_file_name: data['lime_file_name'],
        predicted_class: data['predicted_class']);
  }
}
