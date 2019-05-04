import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/address_bridge.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/utils/uidata.dart';

class AddAddressListPage extends StatefulWidget {
  Address address;

  AddAddressListPage(this.address) {}

  @override
  State<StatefulWidget> createState() {
    return _AddAddressListState(address);
  }
}

class _AddAddressListState extends State<AddAddressListPage> {
  Address address;

  _AddAddressListState(Address address);

  double get deliverPrice => 10;

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
//    ));

    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text(
          "我的地址",
          style: TextStyle(color: UIData.ff353535, fontSize: 18),
        ),
        elevation: 0,
        leading: new IconButton(
          icon: Icon(Icons.arrow_back_ios, color: UIData.ff353535),
          color: UIData.fff,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: buildBody(),
    );
  }

  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController areaEditingController = new TextEditingController();
  TextEditingController addressEditingController = new TextEditingController();

  bool isDefalut = false;

  Widget buildBody() {
    if (address != null) {
      nameEditingController.text = address.name;
      phoneEditingController.text = address.phone;
      //areaEditingController.text = address.area;
      addressEditingController.text = address.address;
      isDefalut = address.status == 1;
    }
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        child: new Column(
          children: <Widget>[
            buildInput(nameEditingController, "请输入收货人姓名"),
            buildInput(phoneEditingController, "请填写收货人手机号码"),
            buildInput(areaEditingController, "点击选择地区"),
            buildInput(addressEditingController, "详情地址"),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: UIData.fffa4848,
                    value: this.isDefalut,
                    onChanged: (bool value) {
                      setState(() {
                        this.isDefalut = value;
                      });
                    },
                  ),
                  Text(
                    "默认地址",
                    style: TextStyle(color: UIData.ff666666, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              child: UIData.getShapeButton(
                  UIData.fffa4848, UIData.fff, 345, 45, "保存", 18, 5, () {
                if (address == null) {
                  address = new Address(
                      name: nameEditingController.text,
                      phone: phoneEditingController.text,
                      //area: areaEditingController.text,
                      address: addressEditingController.text);
                } else {
                  address.name = nameEditingController.text;
                  address.phone = phoneEditingController.text;
                  //address.area = areaEditingController.text;
                  address.address = addressEditingController.text;
                }

                address.status = this.isDefalut ? 1 : 0;
                goToAdd(context, address);
//                setState(() {
//                  if (address == null) {
//                    address = new Address(
//                        name: nameEditingController.text,
//                        phone: phoneEditingController.text,
//                        area: areaEditingController.text,
//                        address: addressEditingController.text);
//                  } else {
//                    address.name = nameEditingController.text;
//                    address.phone = phoneEditingController.text;
//                    address.area = areaEditingController.text;
//                    address.address = addressEditingController.text;
//                  }
//
//                  if (this.isDefalut) {
//                    address.isDefault = true;
//                  }
//                  //AddressManager.instance.addAddress(address);
//                });
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInput(TextEditingController textController, String hinttxt) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 1),
      child: Container(
        height: 48,
        color: Colors.white,
        alignment: Alignment.center,
        child: Center(
          child: TextFormField(
            maxLines: 3,
            obscureText: false,
            textAlign: TextAlign.start,
            controller: textController,
            cursorColor: UIData.fffa4848,
            cursorWidth: 1,
            style: new TextStyle(color: UIData.ff353535, fontSize: 15),
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(18.0, 10, 18.0, 10),
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              ),
              hintText: hinttxt,
              hintMaxLines: 3,
              hintStyle: new TextStyle(color: UIData.ffcccccc, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }

  goToAdd(BuildContext context, Address address) async {
    Future<Result> future = AddressBridge.addAddress(
        address.phone, address.name, address.address, address.status);
    future.then((v) {
      if (v.code == 200) {
        Navigator.pop(context, false);
      } else {
        Bridge.showShortToast(v.msg);
      }
    });
  }
}
