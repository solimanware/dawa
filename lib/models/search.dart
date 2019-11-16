import 'package:dawa/types/drug.dart';
import 'package:diff_match_patch/diff_match_patch.dart';

doSearch(List<Drug> data, term,searchBy, drugController) {
  List<Drug> filteredList;
  List<Drug> fussyList;
  switch(searchBy){
    case "tradename":
      normalFilter(Drug drug) => drug.tradename.toLowerCase().toString().contains(term);
      fussyFilter(Drug drug){
        var matcher = new DiffMatchPatch();
        matcher.matchThreshold = 0.3;
        matcher.matchDistance = 14;
        return matcher.match(drug.tradename.toLowerCase().toString(), term, 0) >-1?true:false;
      }
      filteredList = data.where(normalFilter).toList();
      fussyList = data.where(fussyFilter).toList();
      break;
    case "activeingredient":
      print("Search by Active Ingredient");
      normalFilter(Drug drug) => drug.activeingredient.toLowerCase().toString().contains(term);
      fussyFilter(Drug drug){
        var matcher = new DiffMatchPatch();
        matcher.matchThreshold = 0.3;
        matcher.matchDistance = 14;
        return matcher.match(drug.activeingredient.toLowerCase().toString(), term, 0) >-1?true:false;
      }
      filteredList = data.where(normalFilter).toList();
      fussyList = data.where(fussyFilter).toList();
      break;
    case "price":
      normalFilter(Drug drug) => drug.price.toLowerCase().toString() == term;
      filteredList = data.where(normalFilter).toList();
      fussyList = [];
      break;
    case "company":
      normalFilter(Drug drug) => drug.company.toLowerCase().toString().contains(term);
      fussyFilter(Drug drug){
        var matcher = new DiffMatchPatch();
        matcher.matchThreshold = 0.3;
        matcher.matchDistance = 14;
        return matcher.match(drug.company.toLowerCase().toString(), term, 0) >-1?true:false;
      }
      filteredList = data.where(normalFilter).toList();
      fussyList = data.where(fussyFilter).toList();
      break;
    case "company":
      normalFilter(Drug drug) => drug.company.toLowerCase().toString().contains(term);
      fussyFilter(Drug drug){
        var matcher = new DiffMatchPatch();
        matcher.matchThreshold = 0.3;
        matcher.matchDistance = 14;
        return matcher.match(drug.company.toLowerCase().toString(), term, 0) >-1?true:false;
      }
      filteredList = data.where(normalFilter).toList();
      fussyList = data.where(fussyFilter).toList();
      break;
    case "group":
      normalFilter(Drug drug) => drug.group.toLowerCase().toString().contains(term);
      fussyFilter(Drug drug){
        var matcher = new DiffMatchPatch();
        matcher.matchThreshold = 0.3;
        matcher.matchDistance = 14;
        return matcher.match(drug.group.toLowerCase().toString(), term, 0) >-1?true:false;
      }
      filteredList = data.where(normalFilter).toList();
      fussyList = data.where(fussyFilter).toList();
      break;
    case "pamphlet":
      normalFilter(Drug drug) => drug.pamphlet.toLowerCase().toString().contains(term);
      fussyFilter(Drug drug){
        var matcher = new DiffMatchPatch();
        matcher.matchThreshold = 0.3;
        matcher.matchDistance = 14;
        return matcher.match(drug.pamphlet.toLowerCase().toString(), term, 0) >-1?true:false;
      }
      filteredList = data.where(normalFilter).toList();
      fussyList = data.where(fussyFilter).toList();
      break;
    case "dosage":
      normalFilter(Drug drug) => drug.dosage.toLowerCase().toString().contains(term);
      fussyFilter(Drug drug){
        var matcher = new DiffMatchPatch();
        matcher.matchThreshold = 0.3;
        matcher.matchDistance = 14;
        return matcher.match(drug.dosage.toLowerCase().toString(), term, 0) >-1?true:false;
      }
      filteredList = data.where(normalFilter).toList();
      fussyList = data.where(fussyFilter).toList();
      break;
    case "composition":
      normalFilter(Drug drug) => drug.composition.toLowerCase().toString().contains(term);
      fussyFilter(Drug drug){
        var matcher = new DiffMatchPatch();
        matcher.matchThreshold = 0.3;
        matcher.matchDistance = 14;
        return matcher.match(drug.composition.toLowerCase().toString(), term, 0) >-1?true:false;
      }
      filteredList = data.where(normalFilter).toList();
      fussyList = data.where(fussyFilter).toList();
      break;
  }

print("hi");
  //found results
  if(filteredList.length >= 1){
    drugController.add(filteredList);
  }else{
    //didn't find, do fuzzy
    drugController.add(fussyList);
  }
}