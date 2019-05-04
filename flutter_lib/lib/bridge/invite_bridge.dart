import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

/*
 * 输入邀请码
 */
class InviteBridge {
  static const String component = "invite";
  /*
  被邀请人输入邀请码
 */
  static Future<Result> invitedParent(String inviteCode) async {
    return Bridge.dispenser({
      "method": "invite_parent",
      "params": {
        "action": component,
        "arguments": {
          "method": "invite_parent",
          "data": {"inviteCode": inviteCode},
        }
      }
    });
  }
}
