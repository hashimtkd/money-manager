enum CategoryType { income, expence }

class CategoryModel {
  String name;
  int? key;
  CategoryType? type;
  CategoryModel({required this.name, this.key, this.type});

  Map<String, dynamic> toMap() {
    return {'name': name, 'key': key, 'type': type.toString().split('.').last};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'],
      key: map['key'],
      type: map['type'] == 'income'
          ? CategoryType.income
          : CategoryType.expence,
    );
  }
}
