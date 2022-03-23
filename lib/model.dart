class ModelCategory {
  ModelCategory({
    required this.mainCategoryProductId,
    required this.mainCategoryProductName,
    required this.image,
  });
  late final String mainCategoryProductId;
  late final String mainCategoryProductName;
  late final String image;
  bool open = false;

  ModelCategory.fromJson(Map<String, dynamic> json) {
    mainCategoryProductId = json['main_category_product_id'];
    mainCategoryProductName = json['main_category_product_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['main_category_product_id'] = mainCategoryProductId;
    _data['main_category_product_name'] = mainCategoryProductName;
    _data['image'] = image;

    return _data;
  }
}
