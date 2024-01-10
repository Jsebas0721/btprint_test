import 'package:bluetooth_print/bluetooth_print_model.dart' as bluetooth_print;
import 'package:btprint_test/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BluetoothController bluetoothController = BluetoothController();
  // String macAddress = "00:0C:BF:31:51:29"; // CV_PRINT2 TDM30
  String macAddress = "00:19:0E:A2:F6:68"; // CV_PRINT ALPHA3R
  String device = "CV_PRINT";
  bool isConnected = false;

  //  final List<Map<String, String>> orderList = [
  //   {'orderNum': '4556879'},
  //   {'orderNum': '4554571'},
  //   {'orderNum': '4556972'},
  //   {'orderNum': '4559753'},
  //   {'orderNum': '4551928'},
  // ];
  void connectToDevice() async {
    setState(() {
      bluetoothController.status = "Connecting...";
    });
    Future.delayed(const Duration(seconds: 5), () async {
      isConnected =
          await bluetoothController.bluetoothPrint.isConnected ?? false;
    });

    try {
      await bluetoothController.connectDevice(device, macAddress);
      if (isConnected) {
        setState(() {
          bluetoothController.status = "Connected.";
        });
      }
      print(bluetoothController.status);
    } catch (e) {
      setState(() {
        bluetoothController.status = "Connection Failed!";
      });
      print(bluetoothController.status);
    }
  }

  Future<void> printBarcode(String orderN, String name) async {
    Map<String, dynamic> config = {'width': 51, 'height': 25, 'gap': 2};
    if (isConnected) {
      setState(() {
        bluetoothController.status = "Printing";
      });

      print(orderN);
      List<bluetooth_print.LineText> list = [];
      list.add(bluetooth_print.LineText(
        type: bluetooth_print.LineText.TYPE_BARCODE,
        x: 80,
        y: 25,
        content: orderN,
      ));
      list.add(bluetooth_print.LineText(
        type: bluetooth_print.LineText.TYPE_TEXT,
        x: 80,
        y: 25,
        content: 'name',
      ));

      await bluetoothController.bluetoothPrint.printLabel(config, list);
    } else {
      setState(() {
        bluetoothController.status = "No Device Connected.";
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        appBar: AppBar( 
          title: Image.asset(
            'assets/images/clearvision-logo.png',
            width: double.infinity,
          ),
          foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
          actions: [
            IconButton(
              onPressed: connectToDevice,
              icon: const Icon(Icons.print),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Text(
                  bluetoothController.status,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: TextButton.icon(
                    style: ButtonStyle(
                        iconColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.onPrimary),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer)),
                    label: Text('Print',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary)),
                    onPressed: () async {
                      await printBarcode("4556789", "Sebastian");
                    },
                    icon: const Icon(Icons.print_outlined),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
