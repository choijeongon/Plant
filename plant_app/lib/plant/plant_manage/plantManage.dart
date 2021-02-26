import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:plant_app/network/network.dart';
import 'package:plant_app/plant/plant_manage/plant_manage_detail/plantManageDetail.dart';

const _server_URL = "http://3.35.120.82:3000/";

class PlantManage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BuildListView(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
    );
  }
}

class BuildListView extends StatefulWidget {
  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  List<Plant> plants = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: plants.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
                _server_URL + plants[index].plantName.toString() + ".jpg"),
            backgroundColor: Colors.transparent,
          ),
          title: Text('${plants[index].plantName.toString()}'),
          onTap: () {Get.to(() => PlantManageDetail(), arguments: plants[index]);},
          trailing: Icon(Icons.navigate_next),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  loadData() async {
    String json = await getAllPlants();
    print(json);
    setState(() {
      plants = parseJsonToPlants(json);
      print(plants);
    });
  }
}
