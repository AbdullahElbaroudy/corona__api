import 'dart:ui';

import 'package:covid_19/api/countries_api.dart';
import 'package:covid_19/api/global_api.dart';
import 'package:covid_19/blocs/country_bloc.dart';
import 'package:covid_19/blocs/global_bloc.dart';
import 'package:covid_19/models/country_model.dart';
import 'package:covid_19/models/global_model.dart';
import 'package:covid_19/widgets/tests/test_animation.dart';
import 'package:covid_19/widgets/tests/test_shapes.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Global _global = Global();
  GlobalBloc _globalBloc = GlobalBloc();
  CountryBloc _countryBloc = CountryBloc();
  GlobalApi _globalApi = GlobalApi();
  CountriesApi _countriesApi = CountriesApi();
  List<Country> countries = List<Country>();
  Country _country = Country();
  String _text = "Egypt";
  int indexOfCountry;
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    getGlobal();
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    _globalBloc.dispose();
    _countryBloc.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  getGlobal() async {
    _global = await _globalApi.fetchGlobalInformation();
  }

  double _radius = 0;
  changeRadius() {
    _radius = _radius + 2.0;
  }

  @override
  Widget build(BuildContext context) {
    print("${indexOfCountry}");
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              MyHeader(
                image: "assets/icons/Drcorona.svg",
                textTop: "All you need",
                textBottom: "is stay at home.",
                offset: offset,
              ), 
              Test2(),
              Test1(),
              Row(
                children: <Widget>[
                  rectToCircle(),
                  rectToCircle(),
                  rectToCircle(),
                  rectToCircle(),
                  rectToCircle(),
                  rectToCircle(),
                  rectToCircle(),
                ],
              ),
              MySlider(),
              clipPath1(),
              clipPath2(),
              clipPath3(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                  ),
                ),
                child: FutureBuilder(
                  future: _countriesApi.fetchAllCountry(),
                  builder: (context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: Text("Waiting"));
                        break;
                      default:
                        indexOfCountry = snapshot.data
                            .indexWhere((element) => element.country == _text);
                        print(indexOfCountry);
                        _country = snapshot.data[indexOfCountry];
                        return _drawChooseCountry(snapshot.data);
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    _drawCaseUpdateHeader(),
                    SizedBox(height: 20),
                    StreamBuilder(
                      stream: _globalBloc.globalStream,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Text(" Waiting....");
                            break;
                          default:
                            _globalBloc.addGlobalSink.add(_global);
                            return _drawCaseUpdateBoxg(snapshot.data);
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    _drawSpreadViresHeader(_text),
                    _drawSpreadViresBox(),
                    StreamBuilder(
                      stream: _countryBloc.countryStream,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Text(" Waiting....");
                            break;
                          default:
                            _countryBloc.addCountrySink.add(_country);
                            return _drawCaseUpdateBoxc(snapshot.data);
                        }
                      },
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        controller: controller,
      ),
    );
  }

  Widget _drawChooseCountry(List<Country> countries) {
    return Row(
      children: <Widget>[
        SvgPicture.asset("assets/icons/maps-and-flags.svg"),
        SizedBox(width: 20),
        Expanded(
          child: DropdownButton(
            isExpanded: true,
            underline: SizedBox(),
            icon: SvgPicture.asset("assets/icons/dropdown.svg"),
            value: _text,
            items: countries.map<DropdownMenuItem<String>>((Country value) {
              //  print(value.country);
              return DropdownMenuItem<String>(
                value: value.country,
                child: Text(value.country),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _text = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _drawSpreadViresBox() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      height: 178,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 30,
            color: kShadowColor,
          ),
        ],
      ),
      child: Image.asset(
        "assets/images/map.png",
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _drawSpreadViresHeader(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Spread of Virus in ${text}",
          style: kTitleTextstyle,
        ),
        Text(
          "See details",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _drawCaseUpdateBoxg(Global global) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 30,
            color: kShadowColor,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Counter(
            color: kInfectedColor,
            number: global.totalConfirmed,
            title: "Infected",
          ),
          Counter(
            color: kDeathColor,
            number: global.totalDeaths,
            title: "Deaths",
          ),
          Counter(
            color: kRecovercolor,
            number: global.totalRecovered,
            title: "Recovered",
          ),
        ],
      ),
    );
  }

  Widget _drawCaseUpdateBoxc(Country country) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 30,
            color: kShadowColor,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Counter(
            color: kInfectedColor,
            number: country.totalConfirmed,
            title: "Infected",
          ),
          Counter(
            color: kDeathColor,
            number: country.totalDeaths,
            title: "Deaths",
          ),
          Counter(
            color: kRecovercolor,
            number: country.totalRecovered,
            title: "Recovered",
          ),
        ],
      ),
    );
  }

  Widget _drawCaseUpdateHeader() {
    return Row(
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Case Update\n",
                style: kTitleTextstyle,
              ),
              TextSpan(
                text: "Newest update March 28",
                style: TextStyle(
                  color: kTextLightColor,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Text(
          "See details",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
