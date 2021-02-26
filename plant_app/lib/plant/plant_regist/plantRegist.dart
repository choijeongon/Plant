import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/home/home.dart';
import 'package:plant_app/network/network.dart';

PlantRegistState pageState;

class PlantRegist extends StatefulWidget {
  @override
  PlantRegistState createState() {
    pageState = PlantRegistState();
    return pageState;
  }
}

class PlantRegistState extends State<PlantRegist> {
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  var isChecked = false;

  final _kindsController = TextEditingController();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _cycleController = TextEditingController();

  @override
  void dispose() {
    _kindsController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    _cycleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                width: 117,
                height: 156,
                child: (_image != null) ? Image.file(_image) : Placeholder(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("갤러리"),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  RaisedButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    child: Text("카메라"),
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '*종류',
                        ),
                        controller: _kindsController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return '종류를 입력하세요.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '*이름',
                        ),
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return '이름을 입력하세요.';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                _nameController.text = _kindsController.text;
                                isChecked = value;
                              });
                            },
                          ),
                          Text('종류와 이름 같음'),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '*마지막으로 물 준 날짜',
                        ),
                        readOnly: true,
                        controller: _dateController,
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          _dateController.text = DateFormat('yyyy-MM-dd')
                              .format(await _selectDate());
                          print(_dateController.text);
                        },
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return '날짜를 입력하세요.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "*물을 주는 주기(ex: 7일 -> 숫자 '7'입력)",
                        ),
                        controller: _cycleController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return '주기를 입력하세요.';
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          textColor: Colors.white,
                          padding: EdgeInsets.all(0.0),
                          shape: StadiumBorder(),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF00b09b),
                                  Color(0xFF96c93d),
                                ],
                              ),
                            ),
                            child: Text('등록하기'),
                            padding: EdgeInsets.symmetric(
                                horizontal: 70.0, vertical: 15.0),
                          ),
                          onPressed: () async {
                            if (_image == null) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Image not found'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text('이미지를 찾을 수 없습니다.')
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('취소'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                              return null;
                            }

                            if (_formKey.currentState.validate()) {
                              FormData formData = FormData.fromMap({
                                "plantKind": _kindsController.text.trim(),
                                "plantName": _nameController.text.trim(),
                                "lastDateWater": _dateController.text.trim(),
                                "waterCycle": _cycleController.text.trim(),
                                "imageFilePath": "/images/" +
                                    _nameController.text.trim() +
                                    ".jpg",
                                "file": await MultipartFile.fromFile(
                                    _image.path,
                                    filename: _nameController.text.trim())
                              });

                              Response response = await postPlantInfo(formData);
                              Map<String, dynamic> resultMap;
                              resultMap = json.decode(response.toString());

                              Result result = Result.fromJson(resultMap);
                              print("result = $result");
                              if (result.duplicate == "Yes") {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('중복된 이름'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('이미 사용중인 식물이름 입니다.')
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('취소'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                                return null;
                              }
                              if (result.success == "Yes") {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('등록 완료'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('식물이 등록되었습니다.')
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('확인'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Get.offAll(() => Home());
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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

  Future<DateTime> _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale('ko', 'KO'),
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(data: ThemeData.dark(), child: child);
      },
    );
    if (picked != null) {
      return picked;
    } else {
      return null;
    }
  }
}

class Result {
  final String duplicate;
  final String success;

  Result(this.duplicate, this.success);

  Result.fromJson(Map<String, dynamic> json)
      : duplicate = json['duplicate'],
        success = json['success'];

  Map<String, dynamic> toJson() => {
        'duplicate': duplicate,
        'success': success,
      };
}
