// ignore: empty_constructor_bodies

import '_device.dart';

class Problem{
  String what;
  String why;
  String? when;
  Device device;
 
  Problem(
    this.what,
    this.why, 
    this.when,
    this.device,
  );

  String generateInitialQuery(){ //Still to be implemented
    //remove duplicates in decice, brand, and model names
    return "";
  }
  
}