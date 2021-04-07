class BrandModel {
  String id;
  String brandName;
  String brandInfo;
  String brandLogo;
  String brandBackImage;
  double deliveryPrice;
  Map categories;
  var categoryNumber;
  Map category1;
  Map category2;
  Map category3;
  Map category4;
  Map category5;
  List <dynamic>notes;

  BrandModel({
    this.id,
    this.brandName,
    this.brandInfo,
    this.brandLogo,
    this.brandBackImage,
    this.categoryNumber,
    this.deliveryPrice,
    this.category1,
    this.category2,
    this.category3,
    this.category4,
    this.category5,
    this.categories,
    this.notes
  });
}
