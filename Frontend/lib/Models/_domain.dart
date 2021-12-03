// ignore: empty_constructor_bodies
class Domain{
  String url;
  int isCertified; // trustworthy domain at the our discretion.
  int? likes; //Only applies for non- certified domains
  String baseDomain;
 
  Domain(
    this.url,
    this.isCertified,
    this.likes,
    this.baseDomain
  );
  
}