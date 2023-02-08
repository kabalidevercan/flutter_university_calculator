import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class OrtalamaGoster extends StatelessWidget {
  final double ortalama;
  final int dersSayisi;
  const OrtalamaGoster(
      {Key? key, required this.ortalama, required this.dersSayisi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          dersSayisi > 0 ? "$dersSayisi Ders girildi" : "Ders seçiniz",
          style: Sabitler.dersSayisiStyle,
        ),
        Text(
          ortalama >= 0 ? "${ortalama.toStringAsFixed(2)}" : "0.0",
          style: Sabitler.ortalamaStyle,
        ),
        const Text(
          "Ortalama",
          style: Sabitler.OrtalamaGoster,
        ),
      ],
    );
  }
}
