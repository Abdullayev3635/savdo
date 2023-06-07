class FirmaModel {
  int? id;
  String? title;
  String? image;

  FirmaModel({this.id, required this.title, required this.image});

  FirmaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = title;
    data['image'] = image;

    return data;
  }
}

List<FirmaModel> firmaList = [
  FirmaModel(id: 1, image: 'assets/icons/ic_gallery.svg', title: 'Farg`ona'),
  FirmaModel(id: 2, image: 'assets/icons/ic_gallery.svg', title: 'Andijon'),
  FirmaModel(id: 3, image: 'assets/icons/ic_gallery.svg', title: 'Farg`ona'),
  FirmaModel(id: 4, image: 'assets/icons/ic_gallery.svg', title: 'Namangan'),
  FirmaModel(id: 5, image: 'assets/icons/ic_gallery.svg', title: 'Namangan'),
  FirmaModel(id: 6, image: 'assets/icons/ic_gallery.svg', title: 'Farg`ona'),
  FirmaModel(id: 7, image: 'assets/icons/ic_gallery.svg', title: 'Andijon'),
  FirmaModel(id: 8, image: 'assets/icons/ic_gallery.svg', title: 'Farg`ona'),
  FirmaModel(id: 9, image: 'assets/icons/ic_gallery.svg', title: 'Farg`ona'),
  FirmaModel(id: 10, image: 'assets/icons/ic_gallery.svg', title: 'Andijon'),
  FirmaModel(id: 11, image: 'assets/icons/ic_gallery.svg', title: 'Farg`ona'),
  FirmaModel(id: 12, image: 'assets/icons/ic_gallery.svg', title: 'Andijon'),
  FirmaModel(id: 13, image: 'assets/icons/ic_gallery.svg', title: 'Farg`ona'),
  FirmaModel(id: 14, image: 'assets/icons/ic_gallery.svg', title: 'Andijon'),
];
