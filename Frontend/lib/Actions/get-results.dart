import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:myapp/Models/_domain.dart';
import 'dart:convert';

import 'package:myapp/Models/_results.dart';

Future<Results> getResults(String question) async {
  String urlString =
      'http://notechapi.aidanbuehler.net/results?query=' + question;
  Uri url = Uri.parse(urlString);
  try {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      if(response.body == "{}")  return Results(<TextLink>[], <VideoLink>[]);
      dynamic webPages = json['webPages'] as List;
      dynamic videoPages = json['videos'] as List;
      //if (json.length == 0) return new Results(<TextLink>[], <VideoLink>[]);
      List<TextLink> textLinks = webPages
          .map((item) => new TextLink(
              new Domain(
                  item['url'], item['domainCertified'], item['domainLikes'], item['baseDomain']),
              item['snippet'],
              item['dateLastCrawled'],item['name']))
          .toList()
          .cast<TextLink>();
        List<VideoLink> videoLinks = videoPages
          .map((item) => new VideoLink(
            new Domain(item['contentUrl'], item['domainCertified'], item['domainLikes'],item['baseDomain']),
              item['datePublished'],
              item['duration'],
              item['thumbnailUrl'],
              item['publisher'][0]['name'],
              item['viewCount'],item['name']))
          .toList()
          .cast<VideoLink>();
      Results results = new Results(textLinks, videoLinks);
      return results;
    } else {
      throw Exception('Failed to load results');
    }
  } catch (err) {
    throw Exception('Failed to load results\n' + err.toString());
  }
}
