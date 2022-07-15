import 'package:flutter/material.dart';
import 'package:get/get.dart';


TextStyle get titleTextStyle{
  return TextStyle(
  fontFamily: 'poppins-semibold',
  fontSize: 23,
  color: Get.isDarkMode?Colors.red[100]:Colors.grey

);
} 

TextStyle get kTextStyle1{
  return TextStyle(
  fontFamily: 'poppins-medium',
  fontSize: 14,
);
} 
TextStyle get kTextStyle2 {
  return TextStyle(
  fontFamily: 'poppins',
  fontSize: 14,
);
} 
TextStyle get kTextStyle3 {
  return TextStyle(
  fontFamily: 'poppins-medium',
  fontSize: 14,
);
}
TextStyle get kTextStyle5 {
  return TextStyle(
  fontFamily: 'inter',
  fontSize: 13,
  color: Get.isDarkMode?Colors.white:Colors.black,
);
}

TextStyle get kTextStyle6 {
  return TextStyle(
  fontFamily: 'inter',
  fontSize: 13,
  color: Get.isDarkMode?Colors.black:Colors.white,
);
}

TextStyle get kButtonTextStyle{
  return TextStyle(
  fontFamily: 'poppins-medium',
  fontSize: 16,
  //color: Get.isDarkMode?Colors.grey[500]:Colors.grey

);
}
