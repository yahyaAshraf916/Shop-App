class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = HomeDataModel.fromJson(json["data"]);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json["banners"].forEach((element) {
      banners.add(BannerModel.fromJson (element));
});

      json["products"].forEach((element) {
        products.add( ProductModel.fromJson(element));
      
    });
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}
class ProductResponse {
  bool? status;
  ProductModel? data;
  ProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = ProductModel.fromJson(json['data']);
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorite;
  bool? inChart;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    inFavorite = json["in_favorites"];
    inChart = json["in_chart"];
  }
}
