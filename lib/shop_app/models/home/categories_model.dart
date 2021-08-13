class CategoriesModel {
  late bool status;
  late String message;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? CategoriesDataModel.fromJson(json['data'])
        : null;
  }
}

class CategoriesDataModel {
  List<CategoryModel>? data = [];
  int? currentPage;
  String? firstPageUrl;
  String? lastPageUrl;
  String? nextPageUrl;
  int? from;
  int? to;
  int? total;
  int? lastPage;
  String? path;
  int? perPage;
  String? prevPageUrl;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    from = json['from'];
    to = json['to'];
    total = json['total'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];

    json['data']?.forEach((element) {
      data?.add(CategoryModel.fromJson(element));
    });
  }
}

class CategoryModel {
  late int id;
  late String name;
  String? image;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
