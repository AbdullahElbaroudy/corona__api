import 'dart:convert';


import 'package:covid_19/api/api_utilites.dart';
import 'package:covid_19/models/global_model.dart';
import 'package:http/http.dart' as Http;

class GlobalApi{

Future<Global> fetchGlobalInformation()async{
  String url = baseUrl + summary ;
  var response = await Http.get(url);
  print(response.statusCode);
  if(response.statusCode == 200){
    var decodedJson = jsonDecode(response.body);
    //print(decodedJson['Global']);
    return Global.fromJson(decodedJson['Global']);
    
  }
}
}