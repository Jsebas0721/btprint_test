import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';



class BluetoothController  {
  
final BluetoothDevice _device = BluetoothDevice();
BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
String status = "idle";


Future connectDevice(String deviceName, String macAddress) async {
  _device.name = deviceName;
  _device.address = macAddress;
  return await bluetoothPrint.connect(_device);
}



}