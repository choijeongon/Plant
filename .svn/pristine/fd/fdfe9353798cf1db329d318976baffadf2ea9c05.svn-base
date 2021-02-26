import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_app/network/network.dart';
import 'package:plant_app/plant/plant_manage/plant_manage_detail/plantManageDetail.dart';
import 'package:plant_app/plant/plant_regist/plantRegist.dart';
import 'package:plant_app/constants.dart';

class MiddleSlider extends StatefulWidget {
  @override
  _MiddleSliderState createState() => _MiddleSliderState();
}

class _MiddleSliderState extends State<MiddleSlider> {
  List<Plant> plants = [];
  List<String> plantsImg = [];
  List<Plant> selectPlant = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CarouselSlider(
        options: CarouselOptions(height: 250.0),
        items: plantsImg.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: GestureDetector(
                    child: Image.network(url, fit: BoxFit.cover),
                    onTap: () async {
                      if(searchPlantName(url) == "regist_plant"){
                        Get.to(() => PlantRegist());
                      }
                      
                      String plantObj = await getPlant(searchPlantName(url));
                      setState((){
                        selectPlant = parseJsonToPlants(plantObj);
                        Get.to(() => PlantManageDetail(),
                            arguments: selectPlant[0]);
                      });
                    },
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  loadData() async {
    String json = await getAllPlants();
    setState(() {
      plants = parseJsonToPlants(json);
      for (var i = 0; i < plants.length; i++) {
        plantsImg.add(ServerUrl.url + plants[i].plantName.toString() + ".jpg");
      }

      if (plants.length == 0) {
        plantsImg.add(ServerUrl.url + "regist_plant.png");
      }
    });
  }

  String searchPlantName(String url) {
    String extensionName = url.substring(ServerUrl.url.length);
    String plantName = extensionName.substring(0, extensionName.length - 4);
    return plantName;
  }
}
