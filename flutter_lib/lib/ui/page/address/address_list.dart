import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/logic/viewmodel/deliver_address_manager.dart';
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

  Container buildBody() {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 67,
            left: 10,
            right: 10,
            child: buildListView(),
          ),
          Positioned(
            bottom: 17,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              child:  UIData.getShapeButton(UIData.fffa4848, UIData.fff, 345,
                  45, "添加地址", 18, 5, () {
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

  Widget buildItem(int index) {
    Address address =   AddressManager.instance.getAddresss()[index];

    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
             Checkbox(
               value: address.isDefault, onChanged: (bool value) {setState(() {
                 address.isDefault = value;
               });},
             ),
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          address.name+address.phone,
                          style: TextStyle(color: UIData.ff353535, fontSize: 13),
                        ),
                        Text(
                          address.area+address.address,
                          style: TextStyle(color: UIData.ff999999, fontSize: 12),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new AddAddressListPage(address)));
      },
    );
  }


  ListView buildListView() {
    return ListView.builder(
      itemCount: AddressManager.instance.addresss.length,
      itemBuilder: (context, index) {
        return buildItem(index);
      },
    );
  }

}
