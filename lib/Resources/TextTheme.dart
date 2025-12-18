// Poppins Thin – 100
//
// Poppins ExtraLight – 200
//
// Poppins Light – 300
//
// Poppins Regular – 400
//
// Poppins Medium – 500
//
// Poppins SemiBold – 600
//
// Poppins Bold – 700
//
// Poppins ExtraBold – 800
//
// Poppins Black – 900


import 'package:car_rental_project/Resources/AppTextSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';

class TTextTheme {

  static TextStyle h1Style(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 22, 22, 32),fontWeight: FontWeight.w600,color: AppColors.textColor);
  }

  static TextStyle h3Style(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 14, 26),fontWeight: FontWeight.w600,color: AppColors.textColor);
  }

  static TextStyle h5Style(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 16, 22),fontWeight: FontWeight.w600,color: AppColors.textColor);
  }

  static TextStyle h6Style(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 16, 16, 20),fontWeight: FontWeight.w500,color: AppColors.textColor);
  }

  static TextStyle h7Style(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 14, 20),fontWeight: FontWeight.w600,color: AppColors.textColor);
  }


  static TextStyle btnOne(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 11, 12, 12),fontWeight: FontWeight.w500,color: AppColors.quadrantalTextColor);
  }

  static TextStyle btnTwo(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 12, 12),fontWeight: FontWeight.w400,color: AppColors.secondTextColor);
  }

  static TextStyle btnThree(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 20, 12),fontWeight: FontWeight.w400,color: AppColors.tertiaryTextColor);
  }

  static TextStyle btnFour(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 12, 12),fontWeight: FontWeight.w400,color: AppColors.textColor);
  }
  static TextStyle btnFive(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 9, 9, 12),fontWeight: FontWeight.w400,color: AppColors.quadrantalTextColor);
  }

  static TextStyle btnWhiteColor(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 10, 12),fontWeight: FontWeight.w400,color: Colors.white);// (only for web)
  }

  static TextStyle btnCancel(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 14, 14),fontWeight: FontWeight.w400,color: AppColors.textColor);
  }

  static TextStyle btnConfirm(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 14, 14),fontWeight: FontWeight.w500,color: Colors.white);
  }

  static TextStyle titleOne(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 16, 18),fontWeight: FontWeight.w600,color: AppColors.textColor,
    );
  }

  static TextStyle titleTwo(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 12, 12),fontWeight: FontWeight.w500,color: AppColors.blackColor,
    );
  }

  static TextStyle titleThree(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 12, 12),fontWeight: FontWeight.w400,color: AppColors.quadrantalTextColor,
    );
  }

  static TextStyle titleFour(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 10, 10),fontWeight: FontWeight.w400,color: AppColors.quadrantalTextColor,
    );
  }


  static TextStyle titleFive(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 20, 11),fontWeight: FontWeight.w400,color: AppColors.secondaryColor,
    );
  }

  static TextStyle titleSix(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 10, 14),fontWeight: FontWeight.w400,color: AppColors.quadrantalTextColor,
    );
  }

  static TextStyle titleseven(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 11, 11, 11),fontWeight: FontWeight.w400,color: AppColors.textColor,
    );
  }

  static TextStyle titleeight(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 10, 11),fontWeight: FontWeight.w400,color: Colors.white,
    );
  }


  static TextStyle titleSmallTexts(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 12, 14),fontWeight: FontWeight.w500,color: AppColors.textColor,
    );
  }

  static TextStyle titleSubtleText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 20, 11),fontWeight: FontWeight.w400,color: AppColors.secondaryColor,
    );
  }

  static TextStyle titleUpperHeading(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 12, 12),fontWeight: FontWeight.w400,color: AppColors.quadrantalTextColor,
    );
  }

  static TextStyle smallX(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 11, 11),fontWeight: FontWeight.w300,color: AppColors.quadrantalTextColor,
    );
  }

  static TextStyle smallXX(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 10, 10),fontWeight: FontWeight.w400,color: AppColors.quadrantalTextColor,
    );
  }

  static TextStyle smallXX2(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 20, 10),fontWeight: FontWeight.w400,color: AppColors.secondTextColor,
    );
  }



  static TextStyle pOne(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 11, 11, 11),fontWeight: FontWeight.w400,color: AppColors.textColor,
    );
  }

  static TextStyle pTwo(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 20, 10),fontWeight: FontWeight.w400,color: AppColors.secondTextColor,
    );
  }

  static TextStyle pThree(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 11, 11),fontWeight: FontWeight.w400,color: AppColors.quadrantalTextColor,
    );
  }

  static TextStyle documnetInsideText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 20, 10),fontWeight: FontWeight.w500,color: AppColors.quadrantalTextColor,
    );
  }

  static TextStyle documnetsUpsideText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 20, 12),fontWeight: FontWeight.w500,color: AppColors.textColor,
    );
  }

  static TextStyle documnetIsnideSmallText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 14, 14),fontWeight: FontWeight.w500,color: AppColors.secondTextColor,
    );
  }

  static TextStyle documnetIsnideSmallText2(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 10, 10),fontWeight: FontWeight.w500,color: AppColors.tertiaryTextColor,
    );
  }

  static TextStyle insidetextfieldWrittenText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 20, 10),fontWeight: FontWeight.w400,color: AppColors.blackColor,
    );
  }






  /// Main Functions
  static TextStyle _textStyle (
  {
    double fontSize = 12,
    required FontWeight fontWeight ,
    Color ? color,
})  {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
