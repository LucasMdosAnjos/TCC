import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pneumonia_flutter/app/modules/home/presenter/home_store.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../constants/config_constants.dart';

class PredictResultWidget extends StatefulWidget {
  const PredictResultWidget({super.key});

  @override
  State<PredictResultWidget> createState() => _PredictResultWidgetState();
}

class _PredictResultWidgetState extends State<PredictResultWidget> {
  final HomeStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (store.predictResult != null) {
        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width < 800
                  ? MediaQuery.of(context).size.width * 0.6
                  : 448,
              height: MediaQuery.of(context).size.width < 800
                  ? MediaQuery.of(context).size.width * 0.6
                  : 448,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        '${ConfigConstants.hostnameFlask}/downloadArquivoByNome?file_name=${store.predictResult!.lime_file_name}'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Resultado da classificação:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              '${store.predictResult!.predicted_class} com porcentagem de ${(store.predictResult!.confidence*100).toStringAsFixed(3)}%',
              style: TextStyle(fontSize: 18),
            )
          ],
        );
      } else {
        if(!store.salvando){
          return Container();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                shape: BoxShape.rectangle,
                width: MediaQuery.of(context).size.width < 800
                    ? MediaQuery.of(context).size.width * 0.6
                    : 448,
                height: MediaQuery.of(context).size.width < 800
                    ? MediaQuery.of(context).size.width * 0.6
                    : 448,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SkeletonParagraph(
              style: SkeletonParagraphStyle(
                  lines: 1,
                  spacing: 6,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 20,
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
            SizedBox(
              height: 24,
            ),
            SkeletonParagraph(
              style: SkeletonParagraphStyle(
                  lines: 1,
                  spacing: 6,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 18,
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ],
        );
      }
    });
  }
}
