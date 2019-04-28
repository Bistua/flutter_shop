import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lib/model/fetch_process.dart';
import 'package:flutter_lib/ui/widgets/common_dialogs.dart';
import 'package:flutter_lib/utils/uidata.dart';

apiSubscription(Stream<FetchProcess> apiResult, BuildContext context) {
  apiResult.listen((FetchProcess p) {
    if (p.loading) {
      showProgress(context);
    } else {
      hideProgress(context);
      if (p.response.code == 200) {
        switch (p.type) {
          case ApiType.queryProductList:
          case ApiType.getProductDetail:
          case ApiType.queryProductList:
            break;
          case ApiType.getSkuList:
            showSuccess(context, UIData.success, Icons.check);
            break;
          case ApiType.getSkuResult:
          case ApiType.getProductList:
            break;
        }
      } else {
        fetchApiResult(context, p.response.msg);
      }
    }
  });
}

// void afterLogin(FetchProcess p, BuildContext context) {
//   NetworkServiceResponse<OTPResponse> res = p.response;
//   ISRData.prefs.setString(ISRData.pref_auth_token, res.content.data.authToken);
//   ISRData.prefs.setString(ISRData.pref_user_id, res.content.data.userId);
//   ISRData.prefs.setBool(ISRData.pref_logged_in, true);
//   Navigator.of(context).pushReplacementNamed(ISRData.homeRoute);
// }
