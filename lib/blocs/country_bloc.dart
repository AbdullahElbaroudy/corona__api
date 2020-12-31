import 'dart:async';

import 'package:covid_19/models/country_model.dart';
import 'package:covid_19/models/global_model.dart';

class CountryBloc {
  
  Country _country;

  final StreamController<Country> _countryStreamController =
      StreamController<Country>();
  Stream<Country> get countryStream => _countryStreamController.stream;
  StreamSink<Country> get countrySink => _countryStreamController.sink;

  final StreamController<Country> _addCountryStreamController =
      StreamController<Country>();
  Stream<Country> get addCountryStream => _countryStreamController.stream;
  StreamSink<Country> get addCountrySink => _countryStreamController.sink;
 

addCountry(Country country){
  countrySink.add(country);
}

  CountryBloc() {
    _country = Country(
        newConfirmed: 0,
        newDeaths: 0,
        newRecovered: 0,
        totalDeaths: 0,
        totalConfirmed: 0,
        totalRecovered: 0);
    _countryStreamController.add(_country);

  _addCountryStreamController.stream.listen(addCountry);

  }

  dispose() {
      _countryStreamController.close();
    _addCountryStreamController.close();
  }
}
