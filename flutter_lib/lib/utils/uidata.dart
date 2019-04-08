import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class UIData {
  //routes
  static const String homeRoute = "/home";
  static const String notFoundRoute = "/No Search Result";

  static const String ShopListPage = "/ShopListPage";
  static const String SearchShopList = "/SearchShopList";
  static const String ShopCategoryList = "/ShopCategoryList";
  static const String IviteFriendsPage = "/IviteFriendsPage";
  static const String InviteInputPage = "/InviteInputPage";
  static const String UserHomeListPage = "/UserHomeListPage";

  static const String MineCollectionPage = "/MineCollectionPage";
  static const String OrderDetailPage = "/OrderDetailPage";
  static const String MineOrderPage = "/MineOrderPage";
  static const String OrderCommentPage = "/OrderCommentPage";
  static const String OrderCommentListPage = "/OrderCommentListPage";

  static const String ShopDetailPage = "/ShopDetailPage";

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
  static const Color fffff6f6 = Color(0xfffff6f6);

  static const Color fff6f6f6 = Color(0xfff6f6f6);

  static const Color fff = Color(0xffffffff);
  static const Color ffffe116 = Color(0xffffe116);
  static const Color ffffb414 = Color(0xffffb414);

  static const Color ffffa517 = Color(0xffffa517);

  static const Color ff85b8e7 = Color(0xff85b8e7);
  static const Color ffd5d5d5 = Color(0xffd5d5d5);

  static const Color ffffa5a5 = Color(0xffffa5a5);

  static const Color ff999999 = Color(0xff999999);
  static const Color ff666666 = Color(0xff666666);
  static const Color fff7f7f7 = Color(0xfff7f7f7);


  static const Icon back = Icon(Icons.arrow_back_ios, color: UIData.ff353535);
  static const Icon back_white = Icon(Icons.arrow_back_ios, color: UIData.fff);

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

  static Text getTextWidget(String text, Color color, double fontSize) {
    return Text(text, style: TextStyle(fontSize: fontSize, color: color));
  }

  static Padding getTextWithPading(
      String text, Color color, double fontSize, double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(text, style: TextStyle(fontSize: fontSize, color: color)),
    );
  }

  static AppBar getCenterTitleAppBar(String title, BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: Text(title),
      leading: new IconButton(
        icon: UIData.back,
        onPressed: () => Navigator.pop(context, false),
      ),
    );
  }

  static AppBar getCenterTitleAppBarWithColor(String title,Color color, BuildContext context) {
    return new AppBar(
      backgroundColor: color,
      centerTitle: true,
      title: Text(title),
      leading: new IconButton(
        icon: UIData.back,
        onPressed: () => Navigator.pop(context, false),
      ),
    );
  }


  static Widget getNoShapeButton(double w,double h,Color color,String text) {
    return new Center(
      child: Container(
        alignment: Alignment.center,
        width: w,
        height: h,
        child: new Text(
          '搜索',
          style: TextStyle(color: Colors.white),
        ),
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(14),
          border: new Border.all(
            width: 5.0,
            color: color,
          ),
        ),
      ),
    );
  }

  static Widget getNoElevationShapeButton(Color shapeColor,
      Color textColor,

      String text,
      double fontSize,
      double radius,
      double elevation,
      VoidCallback onPressed){
    if (radius == 0) {
      return new Center(
        child: RaisedButton(
          color: shapeColor,
          textColor: textColor,
          elevation: elevation,
          highlightElevation: elevation,
          disabledElevation: elevation,
          child: new Container(

            child: Center(
              child: UIData.getTextWidget(text, textColor, fontSize),
            ),
          ),
          onPressed: onPressed,
        ),
      );
    } else {
      return new Center(
        child: RaisedButton(
          color: shapeColor,
          textColor: textColor,
          elevation: elevation,
          highlightElevation: elevation,
          disabledElevation: elevation,
          child: new Container(

            child: Center(
              child: UIData.getTextWidget(text, textColor, fontSize),
            ),
          ),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      );
    }
  }

  static Widget getShapeButton(
      Color shapeColor,
      Color textColor,
      double width,
      double height,
      String text,
      double fontSize,
      double radius,
      VoidCallback onPressed) {
    if (radius == 0) {
      return new Center(
        child: RaisedButton(
          color: shapeColor,
          textColor: textColor,
          elevation: 0,
          highlightElevation: 0,
          disabledElevation: 0,
          child: new Container(
            width: width,
            height: height,
            child: Center(
              child: UIData.getTextWidget(text, textColor, fontSize),
            ),
          ),
          onPressed: onPressed,
        ),
      );
    } else {
      return new Center(
        child: RaisedButton(
          color: shapeColor,
          textColor: textColor,
          child: new Container(
            width: width,
            height: height,
            child: Center(
              child: UIData.getTextWidget(text, textColor, fontSize),
            ),
          ),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      );
    }
  }

  static Widget getMaxWidthButtonWithRadius(String text,double radius, VoidCallback onPressed) {
    return getShapeButton(
        UIData.fffa4848, UIData.fff, 315, 50, text, 18, radius, onPressed);
  }

  static Widget getMaxWidthButton(String text, VoidCallback onPressed) {
    return getShapeButton(
        UIData.fffa4848, UIData.fff, 345, 45, text, 18, 5, onPressed);
  }

  static BoxDecoration getCircleBoxDecoration(Color color) {
    return BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    );
  }

  static BoxDecoration buildBoxDecoration(Color color, double radius) {
    return new BoxDecoration(
      color: color,
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(radius),
    );
  }

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }

  //验证手机号
  static bool isPhone(String str) {
    return new RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(str);
  }
}
