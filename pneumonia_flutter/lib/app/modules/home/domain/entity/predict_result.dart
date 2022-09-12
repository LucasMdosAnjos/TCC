class PredictResult {
  double confidence;
  String lime_file_name;
  String predicted_class;

  PredictResult(
      {required this.confidence,
      required this.lime_file_name,
      required this.predicted_class});
}
