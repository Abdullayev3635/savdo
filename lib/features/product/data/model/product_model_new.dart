class ProductsNew {
  int? id;
  String? name;
  String? type;
  String? productGroupId;
  String? productGroupName;
  String? mxikCode;
  String? size;
  int? brandId;
  String? brandName;
  String? residualLimit;
  String? employeeShare;
  int? sizeId;
  String? sizeName;
  String? seasonId;
  String? seasonName;
  int? currencyId;
  String? currencyName;
  String? incomePrice;
  String? image;
  String? barcodeType;
  int? productTypeId;
  String? productTypeName;
  String? plu;
  String? keyboardCode;
  String? scaleId;
  String? scaleName;
  int? productFolderId;
  List<PriceList>? priceList;

  ProductsNew(
      {required this.id,
      required this.name,
      required this.type,
      required this.productGroupId,
      required this.productGroupName,
      required this.mxikCode,
      required this.size,
      required this.brandId,
      required this.brandName,
      required this.residualLimit,
      required this.employeeShare,
      required this.sizeId,
      required this.sizeName,
      required this.seasonId,
      required this.seasonName,
      required this.currencyId,
      required this.currencyName,
      required this.incomePrice,
      required this.image,
      required this.barcodeType,
      required this.productTypeId,
      required this.productTypeName,
      required this.plu,
      required this.keyboardCode,
      required this.scaleId,
      required this.scaleName,
      required this.productFolderId,
      required this.priceList});

  ProductsNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    productGroupId = json['product_group_id'];
    productGroupName = json['product_group_name'];
    mxikCode = json['mxik_code'];
    size = json['size'].toString();
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    residualLimit = json['residual_limit'];
    employeeShare = json['employee_share'];
    sizeId = json['size_id'];
    sizeName = json['size_name'];
    seasonId = json['season_id'];
    seasonName = json['season_name'];
    currencyId = json['currency_id'];
    currencyName = json['currency_name'];
    incomePrice = json['income_price'];
    image = json['image'];
    barcodeType = json['barcode_type'];
    productTypeId = json['product_type_id'];
    productTypeName = json['product_type_name'];
    plu = json['plu'];
    keyboardCode = json['keyboard_code'];
    scaleId = json['scale_id'];
    scaleName = json['scale_name'];
    productFolderId = json['product_folder_id'];
    if (json['price_list'] != String) {
      priceList = <PriceList>[];
      json['price_list'].forEach((v) {
        priceList!.add(PriceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['product_group_id'] = this.productGroupId;
    data['product_group_name'] = this.productGroupName;
    data['mxik_code'] = this.mxikCode;
    data['size'] = this.size;
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['residual_limit'] = this.residualLimit;
    data['employee_share'] = this.employeeShare;
    data['size_id'] = this.sizeId;
    data['size_name'] = this.sizeName;
    data['season_id'] = this.seasonId;
    data['season_name'] = this.seasonName;
    data['currency_id'] = this.currencyId;
    data['currency_name'] = this.currencyName;
    data['income_price'] = this.incomePrice;
    data['image'] = this.image;
    data['barcode_type'] = this.barcodeType;
    data['product_type_id'] = this.productTypeId;
    data['product_type_name'] = this.productTypeName;
    data['plu'] = this.plu;
    data['keyboard_code'] = this.keyboardCode;
    data['scale_id'] = this.scaleId;
    data['scale_name'] = this.scaleName;
    data['product_folder_id'] = this.productFolderId;
    if (this.priceList != null) {
      data['price_list'] = this.priceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PriceList {
  int? id;
  int? priceTypeId;
  String? priceTypeName;
  String? price;
  int? currencyId;
  String? currencyName;
  int? productId;
  String? productName;

  PriceList(
      {this.id,
      this.priceTypeId,
      this.priceTypeName,
      this.price,
      this.currencyId,
      this.currencyName,
      this.productId,
      this.productName});

  PriceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceTypeId = json['price_type_id'];
    priceTypeName = json['price_type_name'];
    price = json['price'].toString();
    currencyId = json['currency_id'];
    currencyName = json['currency_name'];
    productId = json['product_id'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price_type_id'] = this.priceTypeId;
    data['price_type_name'] = this.priceTypeName;
    data['price'] = this.price;
    data['currency_id'] = this.currencyId;
    data['currency_name'] = this.currencyName;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    return data;
  }
}
