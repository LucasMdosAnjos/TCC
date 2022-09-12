
class PredictImageFileException implements Exception {
  final String message;

 PredictImageFileException(this.message);

  @override
  String toString() => 'GetArquivoByIdException(message : $message)';
}