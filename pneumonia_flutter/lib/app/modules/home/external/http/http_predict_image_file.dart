import 'dart:convert';
import 'dart:typed_data';

import 'package:pneumonia_flutter/app/modules/home/domain/errors/errors.dart';
import 'package:pneumonia_flutter/app/modules/home/external/http/mapper.dart';
import 'package:pneumonia_flutter/app/modules/home/infra/datasources/predict_image_file_datasource.dart';

import 'package:http/http.dart' as http;
import '../../../../constants/config_constants.dart';
import '../../domain/entity/params_predict_image_file.dart';
import '../../domain/entity/predict_result.dart';

class HttpPredictImageFile implements PredictImageFileDatasource {
  @override
  Future<PredictResult> predictImageFile(ParamsPredictImageFile params)async {
    try {
      var uri = Uri.parse('${ConfigConstants.hostnameFlask}/predictImageFile');

      var request = http.MultipartRequest("POST", uri);

      var file = http.MultipartFile.fromBytes('archive', params.bytesFile,
           filename: "${params.nome_arquivo}.${params.extensao}");
      request.files.add(file);
      request.fields['nome_arquivo'] = params.nome_arquivo;
      request.fields['extensao'] = params.extensao;

      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return PredictResultMapper.fronJson(Map.from(jsonDecode(response.body)));
      } else {
        throw PredictImageFileException("Erro na API");
      }
    } catch (e) {
      throw PredictImageFileException(e.toString());
    }
  }
}
