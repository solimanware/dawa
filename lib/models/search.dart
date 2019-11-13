import 'package:dawa/types/drug.dart';
import 'package:diff_match_patch/diff_match_patch.dart';

doSearch(List<Drug> data, term, drugController) {
  normalFilter(Drug drug) => drug.tradename.toLowerCase().toString().contains(term);
  fussyFilter(Drug drug){
    var matcher = new DiffMatchPatch();
    matcher.matchThreshold = 0.3;
    matcher.matchDistance = 14;
    return matcher.match(drug.tradename.toLowerCase().toString(), term, 0) >-1?true:false;
  }

  List<Drug> filteredList = data.where(normalFilter).toList();

  //found results
  if(filteredList.length >= 1){
    drugController.add(filteredList);
  }else{
    //didn't find
    List<Drug> fussyList = data.where(fussyFilter).toList();
    drugController.add(fussyList);
  }
}