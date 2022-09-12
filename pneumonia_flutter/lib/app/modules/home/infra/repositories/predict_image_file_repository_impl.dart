import 'package:pneumonia_flutter/app/modules/home/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'dart:typed_data';

import 'package:pneumonia_flutter/app/modules/home/domain/repositories/predict_image_file_repository.dart';
import 'package:pneumonia_flutter/app/modules/home/infra/datasources/predict_image_file_datasource.dart';

import '../../domain/entity/params_predict_image_file.dart';
import '../../domain/entity/predict_result.dart';

class PredictImageFileRepositoryImpl implements PredictImageFileRepository {
  final PredictImageFileDatasource datasource;

  PredictImageFileRepositoryImpl(this.datasource);
  @override
  Future<Either<PredictImageFileException, PredictResult>> predictImageFile(
      ParamsPredictImageFile params) async {
    try {
      return Right(await datasource.predictImageFile(params));
    } on PredictImageFileException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(PredictImageFileException(e.toString()));
    }
  }
}
