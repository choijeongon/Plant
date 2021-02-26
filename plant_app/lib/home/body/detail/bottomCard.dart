import 'package:flutter/material.dart';
import 'package:plant_app/plant/plant_manage/plantManage.dart';
import 'package:plant_app/plant/plant_regist/plantRegist.dart';
import 'package:get/get.dart';

class BottomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => PlantRegist());
          },
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4.0,
                child: Container(
                  child: Center(
                    child: Text('식물 추가'),
                  ),
                  width: 130,
                  height: 130,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => PlantManage());
          },
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4.0,
                child: Container(
                  child: Center(
                    child: Text('식물 관리'),
                  ),
                  width: 130,
                  height: 130,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
