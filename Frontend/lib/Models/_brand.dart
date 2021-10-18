// ignore: empty_constructor_bodies

import '_model.dart';

class Brand{
  String name;
  String id;
  int techSupportNumber;
  Model model;
 
  Brand(
    this.id,
    this.name, 
    this.techSupportNumber,
    this.model,
  );
  
}