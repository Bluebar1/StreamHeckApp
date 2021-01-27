import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:streamheck/Providers/box_create_provider.dart';

class Right extends StatelessWidget {
  final BoxCreateProvider boxCreateProvider;

  Right(this.boxCreateProvider);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Expanded(
        child: Container(
      color: Colors.black,
      child: ListView(children: [
        SizedBox(height: 40),
        SizedBox(
          height: 50,
          width: 200,
          child: TextField(
            style: Theme.of(context).textTheme.bodyText1,
            controller: boxCreateProvider.addressController,
            decoration: InputDecoration(
              hintText: 'Text',
              fillColor: Colors.black,
              hintStyle: Theme.of(context).textTheme.bodyText1,
            ),
            textAlign: TextAlign.center,
            onChanged: (String value) {
              boxCreateProvider.setTitle(value);
            },
          ),
        ),
        Container(
          height: 50,
          width: 200,
          color: Colors.redAccent,
          child: Slider(
              max: 150,
              min: 20,
              value: boxCreateProvider.fontSize,
              onChanged: (value) => boxCreateProvider.setFontSize(value)),
        ),
        Container(
          height: 50,
          width: 200,
          color: Colors.redAccent,
          child: Slider(
              max: width / 4,
              min: -(width / 4),
              value: boxCreateProvider.topPosition,
              onChanged: (value) => boxCreateProvider.setTopPosition(value)),
        ),
        Container(
          height: 50,
          width: 200,
          color: Colors.redAccent,
          child: Slider(
              max: width / 4,
              min: -(width / 4),
              value: boxCreateProvider.leftPosition,
              onChanged: (value) => boxCreateProvider.setLeftPosition(value)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Font:', style: Theme.of(context).textTheme.bodyText1),
              DropdownButton<String>(
                //dropdownColor: Colors.grey,
                value: boxCreateProvider.fontSelection,
                onChanged: (String value) {
                  boxCreateProvider.setFontSelection(value);
                },
                items: <String>['None', 'Montserrat', 'Norican']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText1,
                      ));
                }).toList(),
              )
            ],
          ),
        ),
        Container(
          color: Colors.black,
          width: width / 3,
          height: width / 3,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SlidePicker(
              paletteType: PaletteType.rgb,
              indicatorBorderRadius: BorderRadius.circular(10),
              pickerColor: boxCreateProvider.fontColor,
              onColorChanged: boxCreateProvider.setFontColor,
            ),
          ),
        )
      ]),
    ));
  }
}
