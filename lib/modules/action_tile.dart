import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamheck/Providers/http_provider.dart';
import 'package:streamheck/Providers/socket_server_provider.dart';
import 'package:streamheck/Screens/contacts.dart';

class ActionTile extends StatelessWidget {
  final String tab;
  final int index;
  final HttpProvider httpProvider;

  ActionTile(this.tab, this.index, this.httpProvider);
  @override
  Widget build(BuildContext context) {
    //
    var socketServerProvider = Provider.of<SocketServerProvider>(context);
    var x = MediaQuery.of(context).size.width;
    int leftSelection = httpProvider.macroList[index].leftSelection;
    //
    _action() {
      String action = httpProvider.macroList[index].action;
      switch (httpProvider.macroList[index].actionType) {
        case 'Macro':
          print('macro action called');
          socketServerProvider.runSocketTest(action);
          break;
        case 'HotKey':
          print('hotkey action called');
          socketServerProvider.runHotKey(httpProvider.macroList[index].action);
              //.runHotKey('+(^(%(${httpProvider.macroList[index].action})))');
          break;
        case 'Command':
          print('other action called');
          socketServerProvider.runCommand(action);
          break;
        case 'Paste':
          print('paste line action called');
          socketServerProvider.runPasteLine(action);
          break;
        default:
          print('ERROR: default action called');
      }
    }

    _dynamicFontSize() {
      double bigFont = httpProvider.macroList[index].fontSize;
      double largeTile = (x / 3) - 4;
      double smallTile = (x - 424) / 4;
      return (bigFont * smallTile) / largeTile;
    }

    //
    return GestureDetector(
      onTap: _action,
      child: GridTile(
        child: Stack(
          children: [
            (leftSelection == 0)
                ? Container(
                    color: Color(httpProvider.macroList[index].singleColor),
                  )
                : (leftSelection == 1)
                    ? Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                        colors: [
                          Color(
                              httpProvider.macroList[index].firstGradientColor),
                          Color(httpProvider
                              .macroList[index].secondGradientColor),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      )))
                    : Container(
                        child: Image.network(
                        'http://192.168.1.100:4044/${httpProvider.macroList[index].pickedImage}', // TODO add more request info
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
            Positioned(
                top: httpProvider.macroList[index].topPosition / 2.1,
                left: httpProvider.macroList[index].leftPosition,
                child: Container(
                    width: (x - 424) / 4,
                    child: Text(httpProvider.macroList[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: _dynamicFontSize(),
                            // httpProvider.macroList[index].fontSize /
                            //     1.7,
                            fontFamily: (httpProvider
                                        .macroList[index].fontSelection !=
                                    'None')
                                ? httpProvider.macroList[index].fontSelection
                                : '',
                            color: Color(
                              httpProvider.macroList[index].fontColor,
                            ))))),
          ],
        ),
      ),
    );
  }
}
