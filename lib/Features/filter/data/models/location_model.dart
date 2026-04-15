// lib/models/location_model.dart

import 'package:equatable/equatable.dart';

class Governorate extends Equatable {
  final double latitude;
  final double longitude;
  final String nameInArabic;
  final String nameInEnglish;
  final List<City> citiesAndVillages;

  Governorate({
    required this.latitude,
    required this.longitude,
    required this.nameInArabic,
    required this.nameInEnglish,
    required this.citiesAndVillages,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      latitude: json['Latitude'],
      longitude: json['Longitude'],
      nameInArabic: json['NameInArabic'],
      nameInEnglish: json['NameInEnglish'],
      citiesAndVillages: (json['CitiesAndVillages'] as List)
          .map((city) => City.fromJson(city))
          .toList(),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [latitude, longitude, nameInEnglish, nameInArabic];
}

class City extends Equatable {
  final double latitude;
  final double longitude;
  final String nameInArabic;
  final String nameInEnglish;

  City({
    required this.latitude,
    required this.longitude,
    required this.nameInArabic,
    required this.nameInEnglish,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      latitude: json['Latitude'],
      longitude: json['Longitude'],
      nameInArabic: json['NameInArabic'],
      nameInEnglish: json['NameInEnglish'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [latitude, longitude, nameInEnglish, nameInArabic];
}