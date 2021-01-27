import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streamheck/Providers/box_create_provider.dart';
//import 'package:path/path.dart' as path;

class LeftBottom extends StatelessWidget {
  final BoxCreateProvider boxCreateProvider;

  LeftBottom(this.boxCreateProvider);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    void changeColor(Color col) {
      boxCreateProvider.setColor(col);
    }

    void changeFirstGradientColor(Color col) {
      boxCreateProvider.setFirstGradientColor(col);
    }

    void changeSecondGradientColor(Color col) {
      boxCreateProvider.setSecondGradientColor(col);
    }

    void _launchImagePicker() async {
      print('LAUNCH IMAGE PICKER CALLED');
      //final file = await ImagePicker.pickImage(source: ImageSource.gallery);
      final File image =
          await ImagePicker.pickImage(source: ImageSource.gallery);

      boxCreateProvider.setPickedImage(image);
      //var path = await FlutterAbsolutePath.getAbsolutePath(image.identifier);
      // final appDir = await pPath.getApplicationDocumentsDirectory();
      // final fileNmae = path.basename(image.path);
      //final String path = await image.;
      // await ImagePicker.pickImage(source: ImageSource.gallery));
      print('done');
      //print(file);
    }

    Widget _color() {
      return Container(
        color: Colors.black,
        width: width / 3,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SlidePicker(
            paletteType: PaletteType.rgb,
            indicatorBorderRadius: BorderRadius.circular(10),
            pickerColor: boxCreateProvider.color,
            onColorChanged: changeColor,
          ),
        ),
      );
    }

    Widget _gradient() {
      return Column(
        children: [
          Container(
            color: Colors.black,
            width: width / 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SlidePicker(
                paletteType: PaletteType.rgb,
                indicatorBorderRadius: BorderRadius.circular(10),
                pickerColor: boxCreateProvider.firstGradientColor,
                onColorChanged: changeFirstGradientColor,
              ),
            ),
          ),
          Container(
            color: Colors.black,
            width: width / 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SlidePicker(
                paletteType: PaletteType.rgb,
                indicatorBorderRadius: BorderRadius.circular(10),
                pickerColor: boxCreateProvider.secondGradientColor,
                onColorChanged: changeSecondGradientColor,
              ),
            ),
          )
        ],
      );
    }

    Widget _library() {
      return (boxCreateProvider.pickedImage == null)
          ? SizedBox(
              height: 100,
              child: RaisedButton(
                color: Colors.grey,
                child: Text('Select Photo',
                    style: Theme.of(context).textTheme.bodyText1),
                onPressed: () => _launchImagePicker(),
              ))
          : SizedBox(
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.file(boxCreateProvider.pickedImage)),
                  SizedBox(
                      height: 100,
                      child: RaisedButton(
                        color: Colors.grey,
                        child: Text('Select New Photo',
                            style: Theme.of(context).textTheme.bodyText1),
                        onPressed: () => _launchImagePicker(),
                      ))
                ],
              ),
            );
    }

    return (boxCreateProvider.leftSelection == 0)
        ? Center(
            child: _color(),
          )
        : (boxCreateProvider.leftSelection == 1)
            ? Center(
                child: _gradient(),
              )
            : Center(
                child: _library(),
              );
  }
}
