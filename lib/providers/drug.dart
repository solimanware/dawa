import 'package:dawa/types/drug.dart';
import 'package:dawa/utilities/benchmark.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Drug>>fetchDrugs() async{
  List<Drug> drugs;
  var response = await http.get('https://dawaey.com/api/v3/eg/drugs.json');
  BenchmarkMS("Parsing JSON", (){
    var l = json.decode(response.body)['drugs'] as List;
    drugs = l.map((model)=> Drug.fromJson(model)).toList();
  });
  return drugs;
}