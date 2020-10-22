import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:convert';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  var url =
      'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all';
  var cursor = '';
  List<event> events = [];
  bool isloading = false;
  Widget gradientblock(List texts, List<Color> colors, bool aligncenter) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: colors,
                begin:
                    aligncenter ? Alignment.centerLeft : Alignment.bottomLeft,
                end: aligncenter ? Alignment.centerRight : Alignment.topRight)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            texts[0],
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Text(texts[1],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12)),
          Text(texts[2],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12)),
        ]),
      ),
    );
  }

  Widget gamedetailsblock(event k) {
    String indent;
    if (k.name.length > 30) {
      indent = k.name.substring(0, 26) + '...';
    } else {
      indent = k.name;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Card(
        child: Container(
          height: 180,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Flexible(
              flex: 5,
              child: Image.network(
                k.imgurl,
                fit: BoxFit.cover,
              ),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          indent,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          k.gamename,
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 11),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
  void _getdata() async {
      var data = await http.get(url + '&cursor=' + cursor);
      var jsondata = json.decode(data.body);
      setState(() {
        cursor = jsondata["data"]["cursor"];
        for (var u in jsondata["data"]["tournaments"]) {
          events.add(event(u["name"], u['game_name'], u['cover_url']));
        }
        isloading = false;
      });
    }
    void initState(){
      super.initState();
      _getdata();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: Icon(
                                      Icons.short_text,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            child: Center(
                              child: Text(
                                "Flyingwolf",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Container(),
                        )
                      ],
                    ),
                    //next
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        height: 100,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage("images/a.jpeg"),
                            ),
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Simon Baker",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                  Card(
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          13, 10, 18, 10),
                                      child: RichText(
                                          text: TextSpan(
                                              text: '2250',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 25,
                                                  color: Colors.blue),
                                              children: [
                                            TextSpan(
                                                text: ' Elo rating',
                                                style: TextStyle(
                                                    color: Colors.black38,
                                                    fontSize: 15))
                                          ])),
                                    ),
                                  )
                                ])
                          ],
                        ),
                      ),
                    ),
                    //next
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Card(
                        child: Row(children: [
                          gradientblock(['34', 'Tournaments', 'played'],
                              [Colors.orange[800], Colors.orange[400]], true),
                          SizedBox(
                            width: 1,
                          ),
                          gradientblock(['09', 'Tournaments', 'won'],
                              [Colors.purple[900], Colors.purple[400]], false),
                          SizedBox(
                            width: 1,
                          ),
                          gradientblock(['26%', 'Winning', 'percentage'],
                              [Colors.red[600], Colors.red], true),
                        ]),
                      ),
                    ),
                    //next
                    Text(
                      "Recommended for you",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!isloading &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          setState(() {
                            isloading = true;
                          });
                          _getdata();
                        }
                      },
                      child: ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (BuildContext context, int index) {
                            return gamedetailsblock(events[index]);
                          }),
                    )),
              ),
              Container(
                height: isloading ? 50.0 : 0,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class event {
  event(this.name, this.gamename, this.imgurl);
  String name;
  String gamename;
  String imgurl;
}
