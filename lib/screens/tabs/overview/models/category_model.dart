class Category {
  String category;
  String subcategory;
  String categorytId;

  Category(this.category, this.subcategory, this.categorytId);

  Category.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        subcategory = json['subcategory'],
        categorytId = json['categoryId'];
}