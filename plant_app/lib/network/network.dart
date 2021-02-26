import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/constants.dart';

Future<String> getAllPlants() async {
  var response = await http.get(ServerUrl.url + "allPlant");
  return response.body;
}

Future<String> getPlant(String plantName) async {
  var response = await http.get(ServerUrl.url + "plantName?plantName=$plantName");
  return response.body;
}

Future<Response> postPlantInfo(FormData formData) async {
  try {
    Response response = await Dio().post(ServerUrl.url + "postPlant",
        data: formData, options: Options(responseType: ResponseType.json));
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<Response> updatePlant(String plantName, DateTime nowDate) async {
  Dio dio = new Dio();
  var response = await dio.put(
      ServerUrl.url + "updatePlant?plantName=$plantName&lastDateWater=$nowDate");
  return response;
}

Future<Response> deletePlant(String plantName) async {
  Dio dio = new Dio();
  var response =
      await dio.delete(ServerUrl.url + "deletePlant?plantName=$plantName");
  return response;
}

Future<void> changePlantPicture(FormData formData) async {
  try {
    await Dio().post(ServerUrl.url + "changePlantPicture", data: formData);
  } catch (e) {
    print(e);
  }
}

List<Plant> parseJsonToPlants(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Plant>((json) => Plant.fromJson(json)).toList();
}

class Plant {
  final String plantName;
  final String plantKind;
  final String lastDateWater;
  final int waterCycle;
  final String userId;
  final String imageFilePath;

  Plant(
      {this.plantName,
      this.plantKind,
      this.lastDateWater,
      this.waterCycle,
      this.userId,
      this.imageFilePath});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      plantName: json['plantName'] as String,
      plantKind: json['plantKind'] as String,
      lastDateWater: json['lastDateWater'] as String,
      waterCycle: json['waterCycle'] as int,
      userId: json['userId'] as String,
      imageFilePath: json['imageFilePath'] as String,
    );
  }
}
