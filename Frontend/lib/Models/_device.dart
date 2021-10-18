// ignore: empty_constructor_bodies
import '_brand.dart';

class Device{
  String name;
  String id;
  Brand brand;
  bool isDeviceKnown; // is the device stored in out database
 
  Device(
    this.id,
    this.name,
    this.brand,
    this.isDeviceKnown
  );
  
}