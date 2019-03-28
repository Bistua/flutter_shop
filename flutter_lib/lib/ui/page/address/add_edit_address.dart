import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/logic/viewmodel/deliver_address_manager.dart';
import 'package:flutter_lib/logic/viewmodel/shop_cart_manager.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
    ));

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
  Container buildBody() {
    if (address != null) {
      nameEditingController.text = address.name;
      phoneEditingController.text = address.phone;
      areaEditingController.text = address.area;
      addressEditingController.text = address.address;
      isDefalut = address.isDefault;
    }
    return Container(
      child: new Column(
        children: <Widget>[
          buildInput(nameEditingController, "请输入收货人姓名"),
          Padding(
            padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Divider(),
          ),
          buildInput(phoneEditingController, "请填写收货人手机号码"),
          Padding(
            padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Divider(),
          ),
          buildInput(areaEditingController, "点击选择地区"),
          Padding(
            padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Divider(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 59),
            child: buildInput(addressEditingController, "详情地址"),
          ),
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
              setState(() {
                if (address == null) {
                  address = new Address(
                      name: nameEditingController.text,
                      phone: phoneEditingController.text,
                      area: areaEditingController.text,
                      address: addressEditingController.text);

                } else {
                  address.name = nameEditingController.text;
                  address.phone = phoneEditingController.text;
                  address.area = areaEditingController.text;
                  address.address = addressEditingController.text;

                }


                if(this.isDefalut){
                  address.isDefault = true;
                }
                AddressManager.instance.addAddress(address);

              });
              Navigator.of(context).pop();
            }),
          )
        ],
      ),
    );
  }

  Widget buildInput(TextEditingController textController, String hinttxt) {
    return Container(
      color: Colors.white,
      child: Center(
        child: TextField(
          textAlign: TextAlign.start,
          controller: textController,
          cursorColor: UIData.fffa4848,
          cursorWidth: 1,
          style: new TextStyle(color: UIData.ff353535, fontSize: 15),
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
            fillColor: Colors.white,
            filled: true,

//            suffixIcon: new IconButton(
//              color: UIData.ff353535,
//              icon: Icon(Icons.close),
//              onPressed: () {
//                textController.clear();
//              },
//            ),
            hintText: hinttxt,
            hintMaxLines: 3,
            hintStyle: new TextStyle(color: UIData.ffcccccc, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
