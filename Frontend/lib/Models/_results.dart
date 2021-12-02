import '_domain.dart';

class Results{
  List<TextLink> textLinks;
  List<VideoLink> videoLinks;

  Results(
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
  String  snippet; //Text to be displayed under the link in the results view
  String lastUpdated;
  String name;

  
  TextLink(this.domain, this.snippet, this.lastUpdated, this.name);
}

class VideoLink{
  Domain  domain;
  String uploadDate;
  String minuteLength; 
  String thumbnail;
  String publisher;
  int numViews;
  String name;

  
  
  VideoLink(
    this.domain, 
    this.uploadDate,
    this.minuteLength,
    this.thumbnail,
    this.publisher,
    this.numViews,
    this.name
  );
}