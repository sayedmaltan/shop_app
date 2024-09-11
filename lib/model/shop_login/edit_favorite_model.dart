class EditFavoriteModel{
  late bool status;
  late String message;

  EditFavoriteModel(Map<String,dynamic> model){
    status=model['status'];
    message=model['message'];
  }
}