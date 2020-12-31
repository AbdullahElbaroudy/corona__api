import 'package:covid_19/api/countries_api.dart';

import 'package:covid_19/constant.dart';
import 'package:covid_19/models/country_model.dart';
import 'package:covid_19/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

CountriesApi countriesApi =CountriesApi();
List<Country> countries =List<Country>();
  getCountries()async{
     countries =await countriesApi.fetchAllCountry();
  print(countries[51].slug);
 // print(" index of ey ${countries.indexWhere((element) => element.country=='Egypt')}");
    for (Country item in countries) {
      //print(item.slug);
    }

  }
  @override
  Widget build(BuildContext context) {
  
    getCountries();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(color: kBodyTextColor),
          )),
      home: HomeScreen(),
    );
  }
}

