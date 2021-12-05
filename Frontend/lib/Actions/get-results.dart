import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:myapp/Models/_domain.dart';
import 'dart:convert';

import 'package:myapp/Models/_results.dart';

Future<Results> getResults(String question) async {
  String urlString =
      'https://notechapi.aidanbuehler.net/results?query=' + question;
  Uri url = Uri.parse(urlString);
  try {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      if (response.body == "{}") return Results(<TextLink>[], <VideoLink>[]);
      dynamic webPages = json['webPages'] as List?;
      dynamic videoPages = json['videos'] as List?;
      //debugger();
      //if (json.length == 0) return new Results(<TextLink>[], <VideoLink>[]);
      List<TextLink> textLinks = webPages == null
          ? []
          : webPages
              .map((item) => new TextLink(
                  new Domain(
                      item['contentUrl'] == null ? '' : item['contentUrl'],
                      item['domainCertified'] == null
                          ? 0
                          : item['domainCertified'],
                      item['domainLikes'] == null ? 0 : item['domainLikes'],
                      item['baseDomain'] == null ? '' : item['baseDomain']),
                  item['snippet'] == null ? '' : item['snippet'],
                  item['dateLastCrawled'] == null
                      ? ''
                      : item['dateLastCrawled'],
                  item['name'] == null ? '' : item['name']))
              .toList()
              .cast<TextLink>();
      List<VideoLink> videoLinks = videoPages == null
          ? []
          : videoPages
              .map((item) => new VideoLink(
                  new Domain(
                      item['contentUrl'] == null ? '' : item['contentUrl'],
                      item['domainCertified'] == null
                          ? 0
                          : item['domainCertified'],
                      item['domainLikes'] == null ? 0 : item['domainLikes'],
                      item['baseDomain'] == null ? '' : item['baseDomain']),
                  item['datePublished'] == null ? '' : item['datePublished'],
                  item['duration'] == null ? '' : item['duration'],
                  item['thumbnailUrl'] == null ? '' : item['thumbnailUrl'],
                  item['publisher'][0]['name'] == null
                      ? ''
                      : item['publisher'][0]['name'],
                  item['viewCount'] == null ? 0 : item['viewCount'],
                  item['name']))
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
