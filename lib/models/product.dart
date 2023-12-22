class Product {
  final int id;
  final String name;
  final int points;
  final String description;
  final int productCategory;
  final int subProductCategory;
  final String productCategoryName;
  final String subProductCategoryName;
  final Media media;
  final bool activate;
  Product(
      {
    required this.id,
    required this.name,
    required this.points,
    required this.description,
    required this.productCategory,
    required this.subProductCategory,
    required this.productCategoryName,
    required this.subProductCategoryName,
    required this.media,
    required this.activate,
  }
  );
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      points: json['points'],
      description: json['description'],
      productCategory: json['productCategory'],
      subProductCategory: json['subProductCategory'],
      productCategoryName: json['productCategoryName'],
      subProductCategoryName: json['subProductCategoryName'],
      media: Media.fromJson(json['media']),
      activate: json['activate'],
    );
  }
}
class Media {
  final int id;
  final String name;
  final String fileType;
  final String path;
  final int type;
  Media(
      {
    required this.id,
    required this.name,
    required this.fileType,
    required this.path,
    required this.type,
  }
  );
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      name: json['name'],
      fileType: json['fileType'],
      path: json['path'],
      type: json['type'],
    );
  }
}
