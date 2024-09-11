class CategoriesModel{
  late bool status;
  CategoriesDataModel ?data;

  CategoriesModel(Map<String,dynamic> model){
    status=model['status'];
    data=CategoriesDataModel(model['data']);
  }
}

class CategoriesDataModel{
  late int current_page;
  List<DataModel> ?data=[];
  late String first_page_url;

  CategoriesDataModel(Map<String,dynamic> model)
  {
  current_page=model['current_page'];
  first_page_url=model['first_page_url'];
  model['data'].forEach((value){
    data?.add(DataModel(value));
  });
  }
}

class DataModel{
  late int id;
  late String name;
  late String image;

  DataModel(Map <String,dynamic> model){
    id=model['id'];
    name=model['name'];
    image=model['image'];
  }
}