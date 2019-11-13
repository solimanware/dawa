class Drug{
  int id;
  String tradename;
  String activeingredient;
  String price;
  String company;
  String group;
  String pamphlet;
  String dosage;
  String composition;

  Drug({
    this.id,this.tradename,this.activeingredient,this.price,this.company,this.group,this.pamphlet,this.dosage,this.composition,
  });

  static Drug fromJson(Map<String,dynamic> json){
    return Drug(
      id: json['id'],
      tradename: json['tradename'],
      activeingredient: json['activeingredient'],
      price: json['price'],
      company: json['company'],
      group: json['group'],
      pamphlet: json['pamphlet'],
      dosage: json['dosage'],
      composition: json['composition'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'tradename': tradename,
    'activeingredient': activeingredient,
    'price': price,
    'company': company,
    'group': group,
    'pamphlet': pamphlet,
    'dosage': dosage,
    'composition': composition,
  };
}