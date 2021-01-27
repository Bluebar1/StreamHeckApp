import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamheck/Providers/socket_server_provider.dart';

class CustomBox extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;
  final Color fontColor;
  final int fontPosition; //0 is low, 1 is middle, 2 is high
  final FontStyle fontStyle;
  final String actionType;
  final int index;

  CustomBox(this.color, this.text, this.fontSize, this.fontColor,
      this.fontPosition, this.fontStyle, this.actionType, this.index);

  @override
  Widget build(BuildContext context) {
    var socketServerProvider = Provider.of<SocketServerProvider>(context);

    void _action() {
      print('action called');
      switch (actionType) {
        case 'paste':
          {
            print('paste');
            socketServerProvider.runPaste(index);
          }

          break;

        case 'macro':
          {
            print('macro called');
            //socketServerProvider.runSocketTest(index);
          }
          break;
        default:
      }
    }

    return GestureDetector(
      onTap: () => _action(),
      child: GridTile(
        child: Container(
          color: color,
          child: Center(
              child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }
}
