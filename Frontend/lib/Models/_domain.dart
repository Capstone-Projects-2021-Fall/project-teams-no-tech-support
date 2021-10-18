// ignore: empty_constructor_bodies
class Domain{
  String url;
  String id;
  bool isCertified; // trustworthy domain at the our discretion.
  int? likes; //Only applies for non- certified domains
 
  Domain(
    this.id,
    this.url,
    this.isCertified,
    this.likes
  );
  
}