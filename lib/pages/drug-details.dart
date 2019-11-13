import 'package:dawa/models/similars.dart';
import 'package:dawa/types/drug.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class _DrugDetailsPageState extends State<DrugDetailsPage> {
  Drug drug;
  List<Drug> drugs;
  bool _shouldShowDetailedPharma = false;
  String _detailsText = "View Detailed Pharma";

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _DrugDetailsPageState(this.drug, this.drugs);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
    child: Column(children: <Widget>[
      DrugDetailsCard(drug),
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(padding: EdgeInsets.only(left:24),child: Text("Similars:",textAlign: TextAlign.left,style: TextStyle(fontSize: 25),),),
      ),

      SimilarDrugs()
    ],),
    ));
  }

  Widget DrugDetailsCard(Drug drug) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Card(
            margin: EdgeInsets.only(top: 48, left: 24, right: 24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Tradename: ",
                  style: TextStyle(fontSize: 20),
                ),
                Align(
                  child: Text(drug.tradename,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.deepPurple)),
                ),
                Text("Active Ingredient: ", style: TextStyle(fontSize: 20)),
                Align(
                  child: Text(drug.activeingredient,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.deepPurple)),
                ),
                Row(
                  children: <Widget>[
                    Text("Price: ", style: TextStyle(fontSize: 20)),
                    Text(drug.price,
                        style: TextStyle(fontSize: 22, color: Colors.red))
                  ],
                ),
                Text("Drug Group: ", style: TextStyle(fontSize: 20)),
                Padding(
                  child: Text(
                    drug.group,
                    style: TextStyle(fontSize: 22, color: Colors.deepPurple),
                  ),
                  padding: EdgeInsets.only(left: 24),
                ),
                Text("Company: ", style: TextStyle(fontSize: 20)),
                Padding(
                  child: Text(
                    drug.company,
                    style: TextStyle(fontSize: 15, color: Colors.deepPurple),
                  ),
                  padding: EdgeInsets.only(left: 24),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    child: Text("Report a corection",
                        style:
                            TextStyle(fontSize: 15, color: Colors.deepPurple)),
                  ),
                ),
                if (_shouldShowDetailedPharma)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Composition: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20)),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 24, top: 10, bottom: 10),
                          child: Text(drug.composition),
                        ),
                        Text("Pharmacology: ", style: TextStyle(fontSize: 20)),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 24, top: 10, bottom: 10),
                          child: Text(drug.pamphlet),
                        ),
                        Text("Dose: ", style: TextStyle(fontSize: 20)),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 24, top: 10, bottom: 10),
                          child: Text(drug.dosage),
                        ),
                      ],
                    ),
                  ),
                Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    child: Text(_detailsText),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      setState(() {
                        if (_shouldShowDetailedPharma == false) {
                          _shouldShowDetailedPharma = true;
                          _detailsText = "Hide Detailed Pharma";
                        } else {
                          _shouldShowDetailedPharma = false;
                          _detailsText = "View Detailed Pharma";
                        }
                      });
                    },
                  ),
                ),
                Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 140.0,
                        child: RaisedButton(
                          onPressed: () {
                            _launchURL(
                                "https://www.google.com/search?tbm=isch&q=${this.drug.tradename.split(" ").sublist(0, 2).join(" ")} drug");
                          },
                          child: Text("View Picture"),
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 140.0,
                        child: RaisedButton(
                          onPressed: () {
                            _launchURL(
                                "https://www.google.com/search?q=${this.drug.tradename.split(" ").sublist(0, 2).join(" ")} drug");
                          },
                          child: Text("Google More"),
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))
      ],
    ));
  }

  Widget SimilarDrugs() {
    return FutureBuilder<List<Drug>>(
      future: loadDrugSimilars(drug.activeingredient, drugs),
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<Drug>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Error. none');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return similarsListView(snapshot);
        }
        return null; // unreachable
      },
    );
  }

  Widget similarsListView(snapshot) {
    List<Drug> similars = snapshot.data;

      return Container(
        child: Column(children:[
          for(var similar in similars ) similarCard(similar)
        ]),
      );


  }

  Widget similarCard(Drug drug) {
    return Card(
      margin: EdgeInsets.only(top: 10,left: 24,right: 24),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  drug.tradename,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                drug.price,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.red, fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ],
          )),
    );
  }
}

class DrugDetailsPage extends StatefulWidget {
  final Drug drug;
  final List<Drug> drugs;

  DrugDetailsPage({Key key, @required this.drug, @required this.drugs})
      : super(key: key);

  @override
  _DrugDetailsPageState createState() => new _DrugDetailsPageState(drug, drugs);
}
