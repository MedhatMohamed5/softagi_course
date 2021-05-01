class HomeModel {
  bool status;
  String message;
  HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners']?.forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products']?.forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  int id;
  String image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int id;
  double price;
  double oldPrice;
  double discount;
  String image;
  String name;
  bool inFavorites;
  String description;
  bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    description = json['description'];
    inCart = json['in_cart'];
    price = double.tryParse(json['price'].toString());
    oldPrice = double.tryParse(json['old_price'].toString());
    discount = double.tryParse(json['discount'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
