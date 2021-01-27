import 'package:flutter/material.dart';
import 'package:streamheck/Providers/box_create_provider.dart';

class TileBackGround extends StatelessWidget {
  final BoxCreateProvider boxCreateProvider;

  TileBackGround(this.boxCreateProvider);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget _colorBG() {
      return Container(
        height: (width / 3) - 4,
        width: (width / 3) - 4,
        color: boxCreateProvider.color,
      );
    }

    Widget _gradientBG() {
      return Container(
        height: (width / 3) - 4,
        width: (width / 3) - 4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              boxCreateProvider.firstGradientColor,
              boxCreateProvider.secondGradientColor
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
      );
    }

    Widget _libraryBG() {
      return (boxCreateProvider.pickedImage != null)
          ? SizedBox(
              height: width / 3,
              width: width / 3,
              child: Image.file(
                boxCreateProvider.pickedImage,
                fit: BoxFit.cover,
              ))
          : Center(
              child: Text(
                'no image selected',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
    }

    return (boxCreateProvider.leftSelection == 0)
        ? Center(
            child: _colorBG(),
          )
        : (boxCreateProvider.leftSelection == 1)
            ? Center(
                child: _gradientBG(),
              )
            : Center(
                child: _libraryBG(),
              );
  }
}
