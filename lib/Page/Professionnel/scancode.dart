import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_barcode_scanner/my_barcode_scanner.dart';

class ScanCode extends StatefulWidget {
  ScanCode({Key? key}) : super(key: key);

  @override
  _ScanCodeState createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  String _scanBarcode = 'aucun scan';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          ('Scan code'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => scanBarcodeNormal(),
                    child: Text('Scanner')),
                Text('Scan resultat : $_scanBarcode\n',
                    style: TextStyle(fontSize: 20))
              ])),
    );
  }
}
