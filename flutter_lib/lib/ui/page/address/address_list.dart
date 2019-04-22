import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/bridge/address_bridge.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/logic/bloc/address_bloc.dart';
import 'package:flutter_lib/logic/viewmodel/deliver_address_manager.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/ui/page/address/add_edit_address.dart';
import 'package:flutter_lib/utils/uidata.dart';

class AddressListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddressListState();
  }
}

class _AddressListState extends State<AddressListPage> {
  double get deliverPrice => 10;
  AddressBloc addressBloc = new AddressBloc();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
    ));
    findAddress();
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
      body: bodyData(),
    );
  }

  Widget bodyData() {
    addressBloc.getAddressList();
    return StreamBuilder<List<Address>>(
        stream: addressBloc.productItems,
        builder: (context, snapshot) {
          return buildBody(snapshot.data);
        });
  }

  Container buildBody(List<Address> list) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 67,
            left: 10,
            right: 10,
            child: buildListView(list),
          ),
          Positioned(
            bottom: 17,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              child: UIData.getShapeButton(
                  UIData.fffa4848, UIData.fff, 345, 45, "添加地址", 18, 5, () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new AddAddressListPage(null)));
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(Address address) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: address.status == 1,
                onChanged: (bool value) {
                  setState(() {
                    address.status = value ? 1 : 0;
                  });
                },
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      address.name + address.phone,
                      style: TextStyle(color: UIData.ff353535, fontSize: 13),
                    ),
                    Text(
                      address.address,
                      style: TextStyle(color: UIData.ff999999, fontSize: 12),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new AddAddressListPage(address)));
      },
    );
  }

  ListView buildListView(List<Address> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return buildItem(list[index]);
      },
    );
  }

  findAddress() async {
    Future<Result> future = AddressBridge.findAddress(1, 2000);
    future.then((v) {
      if (v.code == 200) {
        return null;
      } else {
        Bridge.showShortToast(v.msg);
        return null;
      }
    });
  }
}
