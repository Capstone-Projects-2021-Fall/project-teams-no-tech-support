import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:myapp/Actions/get-results.dart';
import 'package:myapp/Actions/get-tech-support-number.dart';
import 'package:myapp/Actions/update-domain-likes-dislike-difference.dart';
import 'package:myapp/Models/_domain.dart';
import 'package:myapp/Models/_results.dart';
import 'dart:async';
import 'package:myapp/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

import 'failurePage.dart';

//import 'package:flutter_session/flutter_session.dart';
enum ResultsPageTabViews { TextResults, VideoResults }

class ResultsPage extends StatefulWidget {
  final String finalQuestion;
  const ResultsPage({Key? key, required this.finalQuestion}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  ResultsPageState createState() => ResultsPageState();
}

class ResultsPageState extends State<ResultsPage>
    with TickerProviderStateMixin {
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  Size deviceSize(BuildContext context) => MediaQuery.of(context).size;
  String importedFinalQuestion =
      ''; // Has  to be immported form previous dart file
  static int targetDeviceWidth = 800;
  /*24 is for notification bar on Android*/

  Results results = new Results([], []);
  //List<TextLink> textlinks = <TextLink>[];
  //List<VideoLink> videoLinks = <VideoLink>[];
  String techSupportPhoneNumber = '';
  late TabController _tabController;
  var size;
  var itemHeight;
  var itemWidth;
  final LocalStorage LikedDomainsDisplayedUrl =
      new LocalStorage('liked_domains');
  final LocalStorage DislikedDomainsDisplayedUrl =
      new LocalStorage('disliked_domains');
  String currentDisplayedUrl = '';

  // List<String> liked

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(ResultsPageTabViews.TextResults.index);
    importedFinalQuestion =
        widget.finalQuestion; // Temporary, get this from previous view
    getResults(importedFinalQuestion).then((value) {
      setState(() {
        results = value;
        //debugger();
      });
    });
    getTechSupportPhoneNumber().then((value) {
      techSupportPhoneNumber = value;
    });
  }

  Widget _buildVideoLinksList() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Final Question",
                  style: TextStyle(
                      color: Colors.orange[300],
                      fontSize: 19,
                      fontFamily: 'RobotoMono'),
                ),
                // Text(
                //   importedFinalQuestion,
                //   style: TextStyle(color: Colors.green[200], fontSize: 14),
                // )
                Padding(padding: const EdgeInsets.fromLTRB(15, 0, 0, 15)),
                SizedBox(
                  width: deviceWidth(context) / 2.5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        border: Border.all(
                            color: Colors.grey.shade300, width: 1.5)),
                    child: Text(importedFinalQuestion),
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 30.0))
              ],
            ),
            results.videoLinks.length == 0
                ? Container(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Text(
                      'Sorry. No video Results Found for "$importedFinalQuestion." Please to to Pages section or go back and edit/filter questions if possible',
                      style: TextStyle(
                          color: Colors.red[300],
                          fontSize: 19,
                          fontFamily: 'RobotoMono'
                          //fontWeight: FontWeight.bold
                          ),
                    ),
                  )
                : Expanded(
                    //height: deviceHeight(context) / 1,
                    //width: deviceWidth(context) / 1.35,
                    child: Container(
                      width: deviceWidth(context) / 1.1,
                      child: GridView.count(
                        shrinkWrap: true,
                        clipBehavior: Clip.hardEdge,
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        childAspectRatio: getSuitableAspectRatioForVideoGrid(),

                        crossAxisCount: getSuitableNumberOfColumnsInVideoGrid(),
                        // Generate 100 widgets that display their index in the List.
                        children:
                            List.generate(results.videoLinks.length, (index) {
                          return InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              openLinkinNewTab(
                                  results.videoLinks[index].domain.url);
                            },
                            child: Card(
                              shadowColor: Colors.black,
                              elevation: 10,
                              child: Column(children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        
                                    children: [
                                      Container(
                                        //color: Colors.grey[200],
                                        child:
                                            Stack(alignment: Alignment.center,
                                                //clipBehavior: Clip.hardEdge,
                                                children: <Widget>[
                                              Container(
                                                child: new Image.network(results
                                                        .videoLinks[index]
                                                        .thumbnail,
                                                     
                                                        width:   deviceWidth(context) > targetDeviceWidth ? deviceWidth(context) * 0.30: deviceWidth(context) * 0.80,
                                                        height: deviceHeight(context) * 0.43,
                                                          fit: deviceWidth(context) > targetDeviceWidth ? BoxFit.fitHeight : BoxFit.fitWidth,
                                                    ),
                                              ),
                                              Icon(
                                                Icons.play_circle_sharp,
                                                color: Colors.grey[100],
                                                size: 60,
                                              ),
                                              Positioned(
                                                bottom: 7,
                                                right: 30,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9.0),
                                                      color:
                                                          Colors.blueGrey[300],
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300,
                                                          width: 1.5)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(7, 2, 7, 2),
                                                    child: Text(
                                                      formatDuration(results
                                                          .videoLinks[index]
                                                          .duration),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ]),
                                        alignment: Alignment.center,
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 0, 0),
                                        child: Text(
                                          results.videoLinks[index].name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 0, 0),
                                        child: Text(
                                          numFormatter(results
                                                  .videoLinks[index].numViews) +
                                              " Views   " +
                                              timeAgoSinceDate(results
                                                  .videoLinks[index]
                                                  .uploadDate),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.account_circle_rounded,
                                              color: Colors.blueGrey[300],
                                              size: 30.0,
                                            ),
                                            Text(
                                              results
                                                  .videoLinks[index].publisher,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 15),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  dynamicLikedDomainsListFromSessionToStringList()
                                                          .contains(results
                                                              .videoLinks[index]
                                                              .domain
                                                              .url)
                                                      ? IconButton(
                                                          icon: const Icon(
                                                              Icons.thumb_up),
                                                          color: Colors.blue,
                                                          iconSize: 25,
                                                          tooltip: 'You Liked',
                                                          onPressed: () {
                                                            handleLikes(
                                                                results
                                                                    .videoLinks[
                                                                        index]
                                                                    .domain
                                                                    .url,
                                                                results
                                                                    .videoLinks[
                                                                        index]
                                                                    .domain
                                                                    .baseDomain);
                                                          },
                                                        )
                                                      : IconButton(
                                                          icon: const Icon(
                                                              Icons.thumb_up),
                                                          color:
                                                              Colors.grey[400],
                                                          iconSize: 15,
                                                          tooltip:
                                                              'Result was helpful',
                                                          onPressed: () {
                                                            handleLikes(
                                                                results
                                                                    .videoLinks[
                                                                        index]
                                                                    .domain
                                                                    .url,
                                                                results
                                                                    .videoLinks[
                                                                        index]
                                                                    .domain
                                                                    .baseDomain);
                                                          },
                                                        ),
                                                  dynamicDislikedDomainsListFromSessionToStringList()
                                                          .contains(results
                                                              .videoLinks[index]
                                                              .domain
                                                              .url)
                                                      ? IconButton(
                                                          icon: const Icon(
                                                              Icons.thumb_down),
                                                          color: Colors.red,
                                                          iconSize: 25,
                                                          tooltip:
                                                              'You Disliked',
                                                          onPressed: () {
                                                            handleDislikes(
                                                                results
                                                                    .videoLinks[
                                                                        index]
                                                                    .domain
                                                                    .url,
                                                                results
                                                                    .videoLinks[
                                                                        index]
                                                                    .domain
                                                                    .baseDomain);
                                                          },
                                                        )
                                                      : IconButton(
                                                          icon: const Icon(
                                                              Icons.thumb_down),
                                                          color:
                                                              Colors.grey[400],
                                                          iconSize: 15,
                                                          tooltip:
                                                              'Result was misleading',
                                                          onPressed: () {
                                                            handleDislikes(
                                                                results
                                                                    .videoLinks[
                                                                        index]
                                                                    .domain
                                                                    .url,
                                                                results
                                                                    .videoLinks[
                                                                        index]
                                                                    .domain
                                                                    .baseDomain);
                                                          },
                                                        ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            globals.comm.mybrand != ''
                ? Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.blueGrey[50],
                      child: SizedBox(
                        width: deviceWidth(context) / 1.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                                primary: Colors.orangeAccent[100],
                              ),
                              onPressed: () {
                                handleNoAnswerFound(context, true);
                              },
                              child: const Text(
                                'Couldn\'t find an answer?',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void handleLikes(String displayUrl, String baseDomain) {
    //debugger();

    if (dynamicLikedDomainsListFromSessionToStringList().isEmpty) {
      updateDomainLikeDislikeDifference(baseDomain, 1).then((value) {
        addToLikedDomainsList(displayUrl);
        if (dynamicDislikedDomainsListFromSessionToStringList()
            .contains(displayUrl)) {
          removeFromDislikedDomainsList(displayUrl);
          updateDomainLikeDislikeDifference(
              baseDomain, 1); //Double like if it was disliked already
        }
      });
    } else {
      if (!dynamicLikedDomainsListFromSessionToStringList()
          .contains(displayUrl)) {
        updateDomainLikeDislikeDifference(baseDomain, 1).then((value) {
          //debugger();
          addToLikedDomainsList(displayUrl);
          if (dynamicDislikedDomainsListFromSessionToStringList()
              .contains(displayUrl)) {
            removeFromDislikedDomainsList(displayUrl);
            updateDomainLikeDislikeDifference(
                baseDomain, 1); //Double like if it was disliked already
          }
        });
      } else {
        updateDomainLikeDislikeDifference(baseDomain, 0)
            .then((value) => removeFromLikedDomainsList(displayUrl));
      }
    }
  }

  void handleDislikes(String displayUrl, String baseDomain) {
    if (dynamicDislikedDomainsListFromSessionToStringList().isEmpty) {
      updateDomainLikeDislikeDifference(baseDomain, 0).then((value) {
        addToDislikedDomainsList(displayUrl);
        if (dynamicLikedDomainsListFromSessionToStringList()
            .contains(displayUrl)) {
          removeFromLikedDomainsList(displayUrl);
          updateDomainLikeDislikeDifference(
              baseDomain, 0); //Double dislike if it was liked already
        }
      });
    } else {
      if (!dynamicDislikedDomainsListFromSessionToStringList()
          .contains(displayUrl)) {
        updateDomainLikeDislikeDifference(baseDomain, 0).then((value) {
          addToDislikedDomainsList(displayUrl);
          if (dynamicLikedDomainsListFromSessionToStringList()
              .contains(displayUrl)) {
            removeFromLikedDomainsList(displayUrl);
            updateDomainLikeDislikeDifference(
                baseDomain, 0); //Double dislike if it was liked already
          }
        });
      } else {
        updateDomainLikeDislikeDifference(baseDomain, 1)
            .then((value) => removeFromDislikedDomainsList(displayUrl));
      }
    }
  }

  List<String> dynamicLikedDomainsListFromSessionToStringList() {
    List<String> currentDomainList = [];
    List<dynamic>? data =
        LikedDomainsDisplayedUrl.getItem('LikedDomainsDisplayedUrl');
    if (data == null) return [];

    currentDomainList = List<String>.from(data);
    ;
    return currentDomainList;
  }

  List<String> dynamicDislikedDomainsListFromSessionToStringList() {
    List<String> currentDomainList = [];
    List<dynamic>? data =
        DislikedDomainsDisplayedUrl.getItem('DislikedDomainsDisplayedUrl');
    if (data == null) return [];
    currentDomainList = List<String>.from(data);
    ;
    return currentDomainList;
  }

  void addToLikedDomainsList(String newDisplayURL) {
    List<String> currentList = dynamicLikedDomainsListFromSessionToStringList();
    currentList.add(newDisplayURL);
    setState(() {
      LikedDomainsDisplayedUrl.setItem("LikedDomainsDisplayedUrl", currentList);
    });
  }

  void removeFromLikedDomainsList(String newDisplayURL) {
    List<String> currentList = dynamicLikedDomainsListFromSessionToStringList();
    currentList.remove(newDisplayURL);
    setState(() {
      LikedDomainsDisplayedUrl.setItem("LikedDomainsDisplayedUrl", currentList);
    });
  }

  void addToDislikedDomainsList(String newDisplayURL) {
    List<String> currentList =
        dynamicDislikedDomainsListFromSessionToStringList();
    currentList.add(newDisplayURL);
    setState(() {
      DislikedDomainsDisplayedUrl.setItem(
          "DislikedDomainsDisplayedUrl", currentList);
    });
  }

  void removeFromDislikedDomainsList(String newDisplayURL) {
    List<String> currentList =
        dynamicDislikedDomainsListFromSessionToStringList();
    currentList.remove(newDisplayURL);
    setState(() {
      DislikedDomainsDisplayedUrl.setItem(
          "DislikedDomainsDisplayedUrl", currentList);
    });
  }

  String numFormatter(int num) {
    
    if (num > 999 && num < 1000000) {
      return (num / 1000).ceil().toString() +
          'K'; // convert to K for number from > 1000 < 1 million
    } else if (num > 1000000) {
      return (num / 1000000).ceil().toString() +
          'M'; // convert to M for number from > 1 million
    } else if (num > 1000000000) {
      return (num / 1000000000).ceil().toString() +
          'B'; // convert to B for number from > 1 billion
    } else {
      return num.toString();
    }
  }

  getSuitableAspectRatioForVideoGrid(){
 
    double width = deviceHeight(context);
    double height = deviceWidth(context);
    double quotient = width/height;

    if(deviceWidth(context) >= targetDeviceWidth){
      return 1/0.9;
    }

    if(quotient >= 1.2){
      return 5/7;
    }
    else if(quotient >= 0.95){
      return 5/6;
    }
    else if(quotient >= 0.76){
      return 5/5.5;
    }
     else if(quotient >= 0.70){
      return 5/5.3;
    }
    else if(quotient >= 0.60){
      return 5/6;
    }
    else if(quotient >= 0.50){
      return 5/5.3;
    }
     else if(quotient >= 0.40){
      return 5/4.8;
    }
   
  }
  getSuitableNumberOfColumnsInVideoGrid(){
 
    double width = deviceHeight(context);
    double height = deviceWidth(context);
    double quotient = width/height;
    if(deviceWidth(context) <= targetDeviceWidth){
      return 1;
    }

    if(quotient > 0.7){
      return 2;
    }
    return 3;
    
   
  }

  String formatDuration(String timeFromAPI) { 
//debugger();
    String formattedDuration = '';
    if(timeFromAPI.contains('H')){

        if(!timeFromAPI.contains('M') && !timeFromAPI.contains('S')){
            timeFromAPI = timeFromAPI + '00M00S';
        }
        else if(!timeFromAPI.contains('M')){
          timeFromAPI = timeFromAPI.replaceAll('H', 'H00M');
        }
        else if(!timeFromAPI.contains('S')){
           timeFromAPI = timeFromAPI.replaceAll('M', 'M00S');
        }


          int minStartIndex = timeFromAPI.indexOf('H');;
          int minEndIndex = timeFromAPI.indexOf('M');

          int secStartIndex = minEndIndex;
          int secEndIndex = timeFromAPI.indexOf('S');

          String minSubString = timeFromAPI.substring(minStartIndex+1,minEndIndex);
          String secSubString = timeFromAPI.substring(secStartIndex+1,secEndIndex);
          if(minSubString.length == 1) {
            timeFromAPI = timeFromAPI.replaceAll(minSubString + 'M', '0'+ minSubString + 'M');
          }
          if(secSubString.length == 1) {
          timeFromAPI=  timeFromAPI.replaceAll(secSubString + 'S', '0'+ secSubString + 'S');
          }
        

    }
    else if(timeFromAPI.contains('M')){
     
        if(!timeFromAPI.contains('S')){
           timeFromAPI = timeFromAPI.replaceAll('M', 'M00S');
        }

        int secStartIndex = timeFromAPI.indexOf('M');;
        int secEndIndex = timeFromAPI.indexOf('S');
        
        String secSubString = timeFromAPI.substring(secStartIndex+1,secEndIndex);
        
        if(secSubString.length == 1) {
          timeFromAPI = timeFromAPI.replaceAll(secSubString + 'S', '0'+ secSubString + 'S');
        }
    }else{
          timeFromAPI = timeFromAPI.replaceAll('PT', 'PT00M');
          int secStartIndex = timeFromAPI.indexOf('M');;
          int secEndIndex = timeFromAPI.indexOf('S');
          String secSubString = timeFromAPI.substring(secStartIndex+1,secEndIndex);
        
          if(secSubString.length == 1) {
            timeFromAPI = timeFromAPI.replaceAll(secSubString + 'S', '0'+ secSubString + 'S');
          }
    }
    
   

     formattedDuration = timeFromAPI.replaceAll('PT', '').replaceAll('M', ':').replaceAll('H', ':').replaceAll('S', '');;
  return formattedDuration;
  }

  static String timeAgoSinceDate(String dateString,
      {bool numericDates = false}) {
    DateTime notificationDate = DateTime.parse(
        dateString); //DateFormat("dd-MM-yyyy h:mma").parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if ((difference.inDays / 365).floor() >= 1 &&
        (difference.inDays / 365).floor() <= 100) {
      return '${(difference.inDays.toInt() / 356).ceil()} years ago';
    } else if ((difference.inDays / 30).floor() >= 1 &&
        (difference.inDays / 30).floor() <= 12) {
      return '${(difference.inDays.toInt() / 30).ceil()} months ago';
    } else if ((difference.inDays / 7).floor() > 1 &&
        (difference.inDays / 7).floor() <= 4) {
      return '${difference.inDays / 7.ceil()} weeks ago';
    } else if (((difference.inDays.toInt()) / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildTextLinksList() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Final Question",
                  style: TextStyle(
                      color: Colors.orange[300],
                      fontSize: 19,
                      fontFamily: 'RobotoMono'),
                ),
                // Text(
                //   importedFinalQuestion,
                //   style: TextStyle(color: Colors.green[200], fontSize: 14),
                // )
                Padding(padding: const EdgeInsets.fromLTRB(15, 0, 0, 15)),
                SizedBox(
                  width: deviceWidth(context) / 2.5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        border: Border.all(
                            color: Colors.grey.shade300, width: 1.5)),
                    child: Text(importedFinalQuestion),
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 30.0))
              ],
            ),
            Expanded(
              child: SizedBox(
                width: deviceWidth(context) <= targetDeviceWidth? (deviceWidth(context)/1.2):(deviceWidth(context)/2),
                child: results.textLinks.length == 0
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(
                          'Sorry. No Results Found for "$importedFinalQuestion." Please go back and edit/filter questions if possible',
                          style: TextStyle(
                              color: Colors.red[300],
                              fontSize: 19,
                              fontFamily: 'RobotoMono'
                              //fontWeight: FontWeight.bold
                              ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis
                            .vertical, // Axis.horizontal for horizontal list view.
                        itemCount: results.textLinks.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Card(
                              elevation: 8,
                              child: ListTile(
                                //tileColor: Colors.lightBlue[50],
                                title: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            results.textLinks[index].name,
                                            style: TextStyle(
                                                color: Colors.blue[500],
                                                fontSize: 19),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                dynamicLikedDomainsListFromSessionToStringList()
                                                        .contains(results
                                                            .textLinks[index]
                                                            .domain
                                                            .url)
                                                    ? IconButton(
                                                        icon: const Icon(
                                                            Icons.thumb_up),
                                                        color: Colors.blue,
                                                        iconSize: 25,
                                                        tooltip: 'You Liked',
                                                        onPressed: () {
                                                          handleLikes(
                                                              results
                                                                  .textLinks[
                                                                      index]
                                                                  .domain
                                                                  .url,
                                                              results
                                                                  .textLinks[
                                                                      index]
                                                                  .domain
                                                                  .baseDomain);

                                                          //debugger();
                                                        },
                                                      )
                                                    : IconButton(
                                                        icon: const Icon(
                                                            Icons.thumb_up),
                                                        color: Colors.grey[400],
                                                        iconSize: 15,
                                                        tooltip:
                                                            'Result was helpful',
                                                        onPressed: () {
                                                          handleLikes(
                                                              results
                                                                  .textLinks[
                                                                      index]
                                                                  .domain
                                                                  .url,
                                                              results
                                                                  .textLinks[
                                                                      index]
                                                                  .domain
                                                                  .baseDomain);
                                                          //setState((){});

                                                          //debugger();
                                                        },
                                                      ),
                                                dynamicDislikedDomainsListFromSessionToStringList()
                                                        .contains(results
                                                            .textLinks[index]
                                                            .domain
                                                            .url)
                                                    ? IconButton(
                                                        icon: const Icon(
                                                            Icons.thumb_down),
                                                        color: Colors.red,
                                                        iconSize: 25,
                                                        tooltip: 'You Disliked',
                                                        onPressed: () {
                                                          handleDislikes(
                                                              results
                                                                  .textLinks[
                                                                      index]
                                                                  .domain
                                                                  .url,
                                                              results
                                                                  .textLinks[
                                                                      index]
                                                                  .domain
                                                                  .baseDomain);
                                                        },
                                                      )
                                                    : IconButton(
                                                        icon: const Icon(
                                                            Icons.thumb_down),
                                                        color: Colors.grey[400],
                                                        iconSize: 15,
                                                        tooltip:
                                                            'Result was misleading',
                                                        onPressed: () {
                                                          handleDislikes(
                                                              results
                                                                  .textLinks[
                                                                      index]
                                                                  .domain
                                                                  .url,
                                                              results
                                                                  .textLinks[
                                                                      index]
                                                                  .domain
                                                                  .baseDomain);
                                                        },
                                                      ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        results.textLinks[index].domain.url,
                                        style: TextStyle(
                                            color: Colors.green[200],
                                            fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                          width: deviceWidth(context) / 2,
                                          child: Text(
                                            results.textLinks[index].snippet,
                                            style: TextStyle(
                                                //color: Colors.orange[300],
                                                fontSize: 16),
                                          )),
                                    ],
                                  ),
                                ),

                                onTap: () {
                                  openLinkinNewTab(
                                      results.textLinks[index].domain.url);
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            SizedBox(height: 20),
            globals.comm.mybrand != ''
                ? Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.blueGrey[50],
                      child: SizedBox(
                        width: deviceWidth(context) <= targetDeviceWidth? (deviceWidth(context)/1.2):(deviceWidth(context)/2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                                primary: Colors.orangeAccent[100],
                              ),
                              onPressed: () {
                                handleNoAnswerFound(context, false);
                              },
                              child: const Text(
                                'Couldn\'t find an answer?',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  void handleNoAnswerFound(BuildContext context, bool forVideoSection) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text(" "),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text(!forVideoSection
                  ? "Do you want to navigate to the video results section?"
                  : "Do you want to navigate to the text results section?"),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 17),
                  primary: Colors.blue[300],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  !forVideoSection
                      ? _tabController
                          .animateTo(ResultsPageTabViews.VideoResults.index)
                      : _tabController
                          .animateTo(ResultsPageTabViews.TextResults.index);
                  // setState(() {

                  // });
                },
                child: const Text('Yes'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 17),
                  primary: Colors.red[300],
                ),
                onPressed: () {
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => failurePage()),
                              );
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  void TechSupportNumberModal(
      BuildContext context, String techSupportNumber, String BrandName) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text(" "),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text("Sorry we couldn't help 😟. Here is " +
                  BrandName +
                  "'s tech support number: " +
                  techSupportNumber),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 17),
                  primary: Colors.blue[300],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

  Future<void> openLinkinNewTab(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.pages),
              text: 'Pages',
            ),
            Tab(
              icon: Icon(Icons.video_collection),
              text: 'Videos',
            ),
          ],
        ),
        title: const Text('Results'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTextLinksList(),
          _buildVideoLinksList(),
        ],
      ),
    );
  }
}
