import 'package:flutter/cupertino.dart';

const primary = Color(0xFF40B7AD);
const textColor = Color(0xFF4A4A4A);
const backgroundColor = Color(0xFF01545D);
const darkBlueColor = Color(0xFF10355B);
const greenOscure = Color(0xFF205A6D);
const greenLight = Color(0xFF008186);
const greenAcents = Color(0xFF53E39C);
const greenAcents2 = Color(0xFF71FEBA);
const colorWhite = Color(0xFFF3F7E0);
const headerColor = Color(0xFFF2F6DF);
const greyColor = Color(0xFF829788);

const gradientColor1 = LinearGradient(
  colors: [
    greenAcents,
    greenAcents2,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const gradientColor2 = LinearGradient(
  colors: [
    greyColor,
    colorWhite,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  //stops: [0.5, 0.5],
);
