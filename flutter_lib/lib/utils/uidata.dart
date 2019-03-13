import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
class UIData {
  //routes
  static const String homeRoute = "/home";
  static const String shoplist = "/shoplist";
  static const String searchShopList = "/search_shop_list";
  static const String notFoundRoute = "/No Search Result";


  //strings
  static const String appName = "Flutter UIKit";

  //fonts
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";

  //images
  static const String imageDir = "assets/images";
  static const String pkImage = "$imageDir/pk.jpg";
  static const String profileImage = "$imageDir/profile.jpg";
  static const String blankImage = "$imageDir/blank.jpg";
  static const String dashboardImage = "$imageDir/dashboard.jpg";
  static const String loginImage = "$imageDir/login.jpg";
  static const String paymentImage = "$imageDir/payment.jpg";
  static const String settingsImage = "$imageDir/setting.jpeg";
  static const String shoppingImage = "$imageDir/shopping.jpeg";
  static const String timelineImage = "$imageDir/timeline.jpeg";
  static const String verifyImage = "$imageDir/verification.jpg";

  //login
  static const String enter_code_label = "Phone Number";
  static const String enter_code_hint = "10 Digit Phone Number";
  static const String enter_otp_label = "OTP";
  static const String enter_otp_hint = "4 Digit OTP";
  static const String get_otp = "Get OTP";
  static const String resend_otp = "Resend OTP";
  static const String login = "Login";
  static const String enter_valid_number = "Enter 10 digit phone number";
  static const String enter_valid_otp = "Enter 4 digit otp";

  //gneric
  static const String error = "Error";
  static const String success = "Success";
  static const String ok = "OK";
  static const String forgot_password = "Forgot Password?";
  static const String something_went_wrong = "Something went wrong";
  static const String coming_soon = "Coming Soon";


  static const MaterialColor ui_kit_color = Colors.grey;
  static const Color ffcccccc = Color(0xffcccccc);


  static const Color ff353535 = Color(0xff353535);
  static const Color fffa4848 = Color(0xfffa4848);
  static const Color fff = Color(0xffffffff);
  static const Color ffffe116 = Color(0xffffe116);
  static const Color ffffa5a5 = Color(0xffffa5a5);

  static const Color ff999999 = Color(0xff999999);





  static const Icon back =  Icon(Icons.arrow_back_ios ,color: UIData.ff353535);


//colors
  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,

  ];
  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];

  //randomcolor
  static final Random _random = new Random();

  static Text getTextWidget(String text,Color color,double fontSize){
    return  Text(text,style: TextStyle(fontSize: fontSize,color: color));
  }

  static Padding getTextWithPading(String text,Color color,double fontSize,double padding){
    return  Padding(
      padding: EdgeInsets.all(padding),
      child: Text(text,style: TextStyle(fontSize: fontSize,color: color)),
    );
  }


  static AppBar getCenterTitleAppBar(String title,BuildContext context){
  return  new AppBar(
     centerTitle: true,
     title: Text(title),
     leading: new IconButton(
       icon: UIData.back,
       onPressed: () => Navigator.pop(context, false),
     ),
   );
 }


  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}
