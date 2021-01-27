import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:streamheck/Providers/box_create_provider.dart';
import 'package:streamheck/Screens/CreateABox/left_bottom.dart';

class Left extends StatelessWidget {
  final BoxCreateProvider boxCreateProvider;

  Left(this.boxCreateProvider);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width / 3,
      color: Colors.black,
      child: ListView(
        //shrinkWrap: true,

        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20.0,
            runSpacing: 20.0,
            children: List<Widget>.generate(
              3,
              (int index) {
                return ChoiceChip(
                  label: Text('${boxCreateProvider.bgList[index]}'),
                  selected: boxCreateProvider.leftSelection == index,
                  onSelected: (bool selected) {
                    selected
                        ? boxCreateProvider.setLeftSelection(index)
                        : boxCreateProvider.setLeftSelection(index);
                  },
                );
              },
            ).toList(),
          ),
          LeftBottom(boxCreateProvider)
          // Text('Background'),
          // Container(
          //   color: Colors.blueAccent,
          //   width: width / 3,
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.vertical,
          //     child: ColorPicker(
          //       //colorPickerWidth: 600,
          //       //pickerAreaHeightPercent: .8,
          //       pickerAreaBorderRadius: BorderRadius.circular(10),
          //       pickerColor: boxCreateProvider.color,
          //       onColorChanged: changeColor,
          //     ),
          //   ),
          // ),
          // Text('test'),
          // Container(
          //   color: Colors.blueAccent,
          //   width: width / 3,
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.vertical,
          //     child: ColorPicker(
          //       //colorPickerWidth: 600,
          //       //pickerAreaHeightPercent: .8,
          //       pickerAreaBorderRadius: BorderRadius.circular(10),
          //       pickerColor: boxCreateProvider.secondColor,
          //       onColorChanged: changeSecondColor,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
//     switch (boxCreateProvider.leftSelection) {
//       case 0:
//          Container(
//           color: Colors.blueAccent,
//           width: width / 3,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: ColorPicker(
//               //colorPickerWidth: 600,
//               //pickerAreaHeightPercent: .8,
//               pickerAreaBorderRadius: BorderRadius.circular(10),
//               pickerColor: boxCreateProvider.color,
//               onColorChanged: changeColor,
//             ),
//           ),
//         );
//         break;
//       case 1:
//          SizedBox(
//           width: width / 3,
//           child: ListView(
//             //shrinkWrap: true,
//             children: [
//               Text('Background'),
//               Container(
//                 color: Colors.blueAccent,
//                 width: width / 3,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: ColorPicker(
//                     //colorPickerWidth: 600,
//                     //pickerAreaHeightPercent: .8,
//                     pickerAreaBorderRadius: BorderRadius.circular(10),
//                     pickerColor: boxCreateProvider.color,
//                     onColorChanged: changeColor,
//                   ),
//                 ),
//               ),
//               Text('test'),
//               Container(
//                 color: Colors.blueAccent,
//                 width: width / 3,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: ColorPicker(
//                     //colorPickerWidth: 600,
//                     //pickerAreaHeightPercent: .8,
//                     pickerAreaBorderRadius: BorderRadius.circular(10),
//                     pickerColor: boxCreateProvider.secondColor,
//                     onColorChanged: changeSecondColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       case 2:
//        Container(
//           width: 100,
//           height: 100,
//           color: Colors.red,
//         );
//       default:
//         return Container(
//           child: Text('Error'),
//         );
//     }
//   }
// }
