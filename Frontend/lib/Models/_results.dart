import '_domain.dart';

class Results{
  String id;
  List<TextLink> textLinks;
  List<VideoLink> videoLinks;

  Results(
    this.id,
    this.textLinks,
    this.videoLinks
  );

  List<TextLink> sortTextLinks(){
     return <TextLink>[]; //temporary, still to implement function
  }
  List<VideoLink> sortTVideoLinks(){
     return <VideoLink>[]; //temporary, still to implement function
  }
}

class TextLink{
  Domain  domain;
  String  summary; //Text to be displayed under the link in the results view

  
  TextLink(this.domain, this.summary);
}

class VideoLink{
  Domain  domain;
  DateTime created;
  int length; //in minutes
  
  
  VideoLink(
    this.domain, 
    this.created,
    this.length
  );
}