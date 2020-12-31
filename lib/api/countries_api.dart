
import 'dart:convert';

import 'package:covid_19/api/api_utilites.dart';
import 'package:covid_19/models/country_model.dart';
import 'package:http/http.dart' as Http;
class CountriesApi
{

 Future<List<Country>> fetchAllCountry()async{
   String url = baseUrl + summary ;
    List<Country> countries =[];
    print(url);
    var response = await Http.get(url);
    if(response.statusCode == 200)
    {
      var decodedJson = jsonDecode(response.body);
      for (var item in decodedJson['Countries']) {
        Country country =Country();
        country = Country.fromJson(item);
        countries.add(country);
      }
    
      return countries ;
    }
  }
}