import 'package:dawa/providers/drug.dart';
import 'package:dawa/types/drug.dart';

Future<List<Drug>> loadDrugSimilars(activeingredient,drugs) async {
  List<Drug> similarDrugs = [];
  for (var drug in drugs) {
    if (activeingredient == drug.activeingredient) {
      similarDrugs.add(drug);
    }
  }
  print(similarDrugs);
  return similarDrugs;
}
