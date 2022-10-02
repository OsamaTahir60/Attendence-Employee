// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee/plugins/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/user_model.dart';

class ShowDetail extends StatefulWidget {
  const ShowDetail({Key? key}) : super(key: key);

  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {

  UserModel loggedInUser = UserModel();
  var arr = [];
  var arr1 = [];
  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc('FqgrjxeEN7YN0gZYyjhkH3qOJTJ2')
  //       .get()
  //       .then((value) {
  //     this.loggedInUser = UserModel.fromMap(value.data());
  //     int num = value.data()!['qr_code'];
  //
  //     print(num);
  //     setState(() {});
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   setState(() {
  //     getdata();
  //   });
  // }
  //  getdata() async {
  //   final _fireStore = FirebaseFirestore.instance;
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _fireStore.collection('users').get();
  //
  //   // Get data from docs and convert map to List
  //   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   //for a specific field
  //   final allData1 =
  //   querySnapshot.docs.map((doc) => doc.get('qr_code')).toList();
  //   final allData2 =
  //   querySnapshot.docs.map((doc) => doc.get('email')).toList();
  //
  //   // print(allData1);
  //   arr=allData1;
  //   arr1 = allData2;
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: InkWell(
          onTap: () async {
            final _fireStore = FirebaseFirestore.instance;
            // Get docs from collection reference
            QuerySnapshot querySnapshot = await _fireStore.collection('users').get();

            // Get data from docs and convert map to List
            final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
            //for a specific field
            final allData1 =
            querySnapshot.docs.map((doc) => doc.get('qr_code')).toList();
            final allData2 =
            querySnapshot.docs.map((doc) => doc.get('email')).toList();

            // print(allData1);
            arr=allData1;
            arr1 = allData2;
            // print(arr[0]);
          },
          child: Text(
            'Show Data',
          ),
        )
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: arr.length,
          itemBuilder: (context, index) => Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.red,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                     ListTile(
                       title:  Row(
                         children:  [
                           Text(
                               'Qr Code: ',
                               style: TextStyle(fontSize: 3.0 * SizeConfig.textMultiplier!)
                           ),
                           Text(arr1[index].toString(),style: TextStyle(fontSize: 3.0 * SizeConfig.textMultiplier!),),
                         ],
                       ),
                      subtitle: Row(
                        children:  [
                          Text(
                              'Qr Code: ',
                              style: TextStyle(fontSize: 3.0 * SizeConfig.textMultiplier!)
                          ),
                          Text(arr[index].toString(),style: TextStyle(fontSize: 3.0 * SizeConfig.textMultiplier!),),
                        ],
                      )
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }


}
