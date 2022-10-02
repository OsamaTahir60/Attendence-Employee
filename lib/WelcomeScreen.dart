// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee/model/user_model.dart';
import 'package:employee/plugins/size_config.dart';
import 'package:employee/showdetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final TextEditingController name = new TextEditingController();

  String qrCodeResult = "Not Yet Scanned";
  String barcodeScanRes = "nothing";
  String qr_code = "s";
  int qr = 1;

  int freeMeal = 1;
  int check = 0;
  User? user = FirebaseAuth.instance.currentUser;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        top: false,
        child: mainContent(),
      ),
    );
  }

  Widget mainContent() {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 25.0 * SizeConfig.heightMultiplier!,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: FittedBox(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10 * SizeConfig.heightMultiplier!,
                          left: 7 * SizeConfig.heightMultiplier!),
                      child: Text(
                        'Enter Id',
                        style: TextStyle(
                          fontSize: 2.8 * SizeConfig.textMultiplier!,
                          fontFamily: 'OpenSans_semibold',
                          color: Color(0xff6D6B6B),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ))),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 75.0 * SizeConfig.widthMultiplier!,
                height: 7.5 * SizeConfig.heightMultiplier!,
                margin:
                EdgeInsets.only(top: 0.5 * SizeConfig.heightMultiplier!),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      stops: [
                        0.01,
                        0.4,
                        0.8
                      ],
                      colors: [
                        Color(0xffC1272D),
                        Color(0xff651C69),
                        Color(0xff28225E),
                      ]),
                ),
                child: Container(
                  margin: EdgeInsets.all(0.5 * SizeConfig.heightMultiplier!),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Container(
                    //top:0.5*SizeConfig.heightMultiplier
                    padding: EdgeInsets.only(
                        top: 0.3 * SizeConfig.heightMultiplier!,
                        left: 2.5 * SizeConfig.heightMultiplier!,
                        right: 2.5 * SizeConfig.heightMultiplier!),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.white),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 2.3 * SizeConfig.textMultiplier!,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Id',
                        hintStyle: TextStyle(
                            fontSize: 2.3 * SizeConfig.textMultiplier!,
                            color: Color(0xffC5C2C2),
                            fontFamily: "OpenSans"),
                      ),
                      keyboardType: TextInputType.text,
                      controller: name,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.0 * SizeConfig.heightMultiplier!,),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 75.0 * SizeConfig.widthMultiplier!,
                height: 7.0 * SizeConfig.heightMultiplier!,
                margin: EdgeInsets.only(
                    top: 1.0 * SizeConfig.heightMultiplier!,
                    bottom: 1.0 * SizeConfig.heightMultiplier!),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xffC1272D),
                        Color(0xffC1272D),
                        Color(0xff7D1A6D),
                        Color(0xff28225E)
                      ]),
                ),
                child: TextButton(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 2.8 * SizeConfig.textMultiplier!,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        color: Colors.white),
                  ),
                  onPressed: (){
                    firebaseFirestore
                        .collection("users")
                        .doc('$name')
                        .get()
                        .then((value) {
                      int num = value.data()!['qr_code'];
                      qr = num + 1;
                      Fluttertoast.showToast(
                          msg: " Qr Code added",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      // print(qr);
                      // print(barcode);
                      if (qr == 11) {
                        int freemeal = value.data()!['freeMeal'];
                        check = freemeal + 1;
                        Fluttertoast.showToast(
                            msg: '$check' + "added",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        qr = 0;
                      }
                    });
                    firebaseFirestore
                        .collection("users")
                        .doc('$barcodeScanRes')
                        .update({"qr_code": qr}).then((_) {
                      // print("success!");
                    });
                    firebaseFirestore
                        .collection("users")
                        .doc('$barcodeScanRes')
                        .update({"freeMeal": check}).then((_) {
                      // print("success!");
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 0.0 * SizeConfig.heightMultiplier!,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: FittedBox(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 0 * SizeConfig.heightMultiplier!,
                          left: 7 * SizeConfig.heightMultiplier!),
                      child: Text(
                        'Or',
                        style: TextStyle(
                          fontSize: 2.8 * SizeConfig.textMultiplier!,
                          fontFamily: 'OpenSans_semibold',
                          color: Color(0xff6D6B6B),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ))),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 75.0 * SizeConfig.widthMultiplier!,
                height: 7.0 * SizeConfig.heightMultiplier!,
                margin: EdgeInsets.only(
                    top: 1.0 * SizeConfig.heightMultiplier!,
                    bottom: 1.0 * SizeConfig.heightMultiplier!),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xffC1272D),
                        Color(0xffC1272D),
                        Color(0xff7D1A6D),
                        Color(0xff28225E)
                      ]),
                ),
                child: TextButton(
                  child: Text(
                    'Start Barcode scan',
                    style: TextStyle(
                        fontSize: 2.8 * SizeConfig.textMultiplier!,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        color: Colors.white),
                  ),
                  onPressed: scanBarcode,
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: FittedBox(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 0 * SizeConfig.heightMultiplier!,
                          left: 7 * SizeConfig.heightMultiplier!),
                      child: Text(
                        'Or',
                        style: TextStyle(
                          fontSize: 2.8 * SizeConfig.textMultiplier!,
                          fontFamily: 'OpenSans_semibold',
                          color: Color(0xff6D6B6B),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ))),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 75.0 * SizeConfig.widthMultiplier!,
                height: 7.0 * SizeConfig.heightMultiplier!,
                margin: EdgeInsets.only(
                    top: 1.0 * SizeConfig.heightMultiplier!,
                    bottom: 1.0 * SizeConfig.heightMultiplier!),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xffC1272D),
                        Color(0xffC1272D),
                        Color(0xff7D1A6D),
                        Color(0xff28225E)
                      ]),
                ),
                child: TextButton(
                  child: Text(
                    'Users Detail',
                    style: TextStyle(
                        fontSize: 2.8 * SizeConfig.textMultiplier!,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        color: Colors.white),
                  ),
                  onPressed: () async {
                    // final _fireStore = FirebaseFirestore.instance;
                    // // Get docs from collection reference
                    // QuerySnapshot querySnapshot = await _fireStore.collection('users').get();
                    //
                    // // Get data from docs and convert map to List
                    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
                    // //for a specific field
                    // final allData1 =
                    // querySnapshot.docs.map((doc) => doc.get('qr_code')).toList();
                    //
                    // print(allData1);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ShowDetail()));
                  },
                ),
              ),
            ),


          ]),
    );
  }

  Future<void> scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if (!mounted) return;
      setState(() {
        this.barcodeScanRes = barcode;

        firebaseFirestore
            .collection("users")
            .doc('$barcodeScanRes')
            .get()
            .then((value) {
          int num = value.data()!['qr_code'];
          qr = num + 1;
          Fluttertoast.showToast(
              msg: " Qr Code added",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          // print(qr);
          // print(barcode);
          if (qr == 11) {
            int freemeal = value.data()!['freeMeal'];
            check = freemeal + 1;
            Fluttertoast.showToast(
                msg: '$check' + "added",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            qr = 0;
          }
        });
        firebaseFirestore
            .collection("users")
            .doc('$barcodeScanRes')
            .update({"qr_code": qr}).then((_) {
          // print("success!");
        });
        firebaseFirestore
            .collection("users")
            .doc('$barcodeScanRes')
            .update({"freeMeal": check}).then((_) {
          // print("success!");
        });
      });
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
