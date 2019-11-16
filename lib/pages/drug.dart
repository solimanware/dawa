import 'package:dawa/models/search.dart';
import 'package:dawa/pages/drug-details.dart';
import 'package:dawa/providers/drug.dart';
import 'package:dawa/types/drug.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:diff_match_patch/diff_match_patch.dart';

class _DrugPageState extends State<DrugPage> {
  List<Drug> drugs;
  StreamController drugController =
      new StreamController<List<Drug>>.broadcast();
  String term = "";
  String searchBy = "tradename";
  String searchByText = "Tradename";
  final objectSchema = {
    "id":"ID",
    "tradename": "Trade Name",
    "activeingredient": "Active Ingredent",
    "price": "Price",
    "company": "Company",
    "group": "Group",
    "pamphlet":"Pamphlet",
    "dosage":"Dose",
    "composition":"Composition"
  };



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDrugs().then((data) {
      drugs = data;
      drugController.add(data);
    });
  }

  getStream() {
    return drugController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        searchCard(),
        SizedBox(
          height: MediaQuery.of(context).size.height - 30,
          child: drugStreamList(),
        )
      ],
    );
  }

  onTextChanged(text) {
    doSearch(drugs, text,searchBy, drugController);
    term = text;
  }


  final objectArraySchema = [
    {"key": "id", "value": "ID"},
    {"key": "tradename", "value": "Trade Name"},
    {"key": "activeingredient", "value": "Active Ingredent"},
    {"key": "price", "value": "Price"},
    {"key": "company", "value": "Company"},
    {"key": "group", "value": "Group"},
    {"key": "pamphlet", "value": "Pamphlet"},
    {"key": "dosage", "value": "Dose"},
    {"key": "composition", "value": "Composition"}
  ];

  Future<String> filterDialog() async {

      switch (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('Search By'),
              children: <Widget>[

            for (var object in objectArraySchema) SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, object["key"]);
                  },
                  child: Text(object["value"]),
                ),
              ],
            );
          })) {
        case "id":
          return "id";
          break;
        case "tradename":
          return "tradenmae";
          break;
        case "activeingredient":
          return "activeingredient";
          break;
        case "price":
          return "price";
          break;
        case "company":
          return "company";
          break;
        case "group":
          return "group";
          break;
        case "pamphlet":
          return "pamphlet";
          break;
        case "dosage":
          return "dosage";
          break;
        case "composition":
          return "composition";
          break;
      }

  }

  Widget searchCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.search),
                onTap: () {
                  //open options
                  filterDialog().then((res) {
                    setState(() {
                      searchByText = objectSchema[res];
                      searchBy = res;
                      print(searchByText);
                    });
                  });
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search by " + searchByText +" ..."),
                  onChanged: onTextChanged,
                ),
              ),
              Icon(Icons.menu),
            ],
          ),
        ),
      ),
    );
  }

  Widget drugStreamList() {
    return new StreamBuilder<List<Drug>>(
      stream: getStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Status: none');
          case ConnectionState.waiting:
            return Text(
              'Loading... ⏳',
              textAlign: TextAlign.center,
            );
          case ConnectionState.active:
            return drugListView(context, snapshot);
          //add data here
          case ConnectionState.done:
            return drugListView(context, snapshot);
        }
        return null; //unreachable
      },
    );
  }

  Widget drugListView(BuildContext context, AsyncSnapshot snapshot) {
    if (term.length == 0) {
      return Text(
        'Ready to Search 😁',
        textAlign: TextAlign.center,
      );
    } else {
      List<Drug> values = snapshot.data;
      return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: values.length,
          itemBuilder: (BuildContext context, int index) {
            return drugCard(values[index]);
          });
    }
  }

  Widget drugCard(Drug drug) {
    return new Column(
      children: <Widget>[
        new ListTile(
          leading: Icon(Icons.healing),
          title: Text(
            drug.tradename,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: drug.activeingredient.length != null
              ? Text(drug.activeingredient, overflow: TextOverflow.ellipsis)
              : null,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DrugDetailsPage(drug: drug, drugs: drugs),
              ),
            );
          },
        ),
        new Divider(
          height: 2.0,
        ),
      ],
    );
  }
}

class DrugPage extends StatefulWidget {
  @override
  _DrugPageState createState() => new _DrugPageState();
}
