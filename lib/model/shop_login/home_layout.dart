class HomeLayout {
  late bool status;
  Data? data;

  HomeLayout(Map<String,dynamic> data){
    status=data['status'];
    this.data=Data(data['data']) ;
  }
}
class Data{
  List<BannerClass> banners=[];
  List<ProductsClass> products=[];
  late String ad;
  Data(Map<String,dynamic> data){
    ad=data['ad'];
    data['banners'].forEach((value){
      banners?.add(BannerClass(value));
    });
    data['products'].forEach((value){
      products?.add(ProductsClass(value));
    });
  }

}
class BannerClass{
  late int id;
  late String image;
  BannerClass(Map<String,dynamic> data){
    id=data['id'];
    image=data['image'];
  }
}
class ProductsClass{
  late int id;
  late var price;
  late var old_price;
  late var discount;
  late String image;
  late String name;
  late String description;
  late bool in_favorites;
  late bool in_cart;
  ProductsClass(Map<String,dynamic> data){
    id=data['id'];
    price=data['price'];
    old_price=data['old_price'];
    discount=data['discount'];
    image=data['image'];
    name=data['name'];
    description=data['description'];
    in_favorites=data['in_favorites'];
    in_cart=data['in_cart'];
  }
}