import 'package:flutter_lib/model/rankList.dart';
import 'package:flutter_lib/utils/uidata.dart';

class RankViewModel {
  List<Rank> rankList;

  RankViewModel({this.rankList});

  getMenuItems() {
    return rankList = <Rank>[
      Rank(
          color: UIData.fffa4848,
          name: "二师弟",
          xiaofei: "累计1650.00，已返利金币30个",
          fanli: 30),
      Rank(
          color: UIData.ffffb414,
          name: "沙和尚",
          xiaofei: "累计1650.00，已返利金币30个",
          fanli: 0),
      Rank(
          color: UIData.ff85b8e7,
          name: "沙和尚",
          xiaofei: "累计1650.00，已返利金币30个",
          fanli: 30),
      Rank(
          color: UIData.ffd5d5d5,
          name: "沙和尚",
          xiaofei: "累计1650.00，已返利金币30个",
          fanli: 0),
    ];
  }
}
