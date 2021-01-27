import 'package:flutter/material.dart';
import 'package:streamheck/Providers/box_create_provider.dart';
import 'package:streamheck/Screens/CreateABox/tile_background.dart';
import 'package:streamheck/Screens/avail_macros_page.dart';
import 'package:streamheck/Screens/contacts.dart';
import 'package:streamheck/modules/avail_module.dart';

class Middle extends StatelessWidget {
  final String customTab;
  final BoxCreateProvider boxCreateProvider;

  Middle(this.boxCreateProvider, this.customTab);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Alert Dialog title"),
            content: AvailMacrosPage(),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
      width: width / 3,
      color: Colors.black,
      child: ListView(
        children: [
          SizedBox(height: 30),
          Stack(children: [
            TileBackGround(boxCreateProvider),
            Positioned(
                top: boxCreateProvider.topPosition,
                left: boxCreateProvider.leftPosition,
                child: SizedBox(
                  width: (width / 3) - 4,
                  height: (width / 3) - 4,
                  child: Text(boxCreateProvider.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: boxCreateProvider.fontSize,
                          fontFamily:
                              (boxCreateProvider.fontSelection != 'None')
                                  ? boxCreateProvider.fontSelection
                                  : '',
                          color: boxCreateProvider.fontColor)),
                ))
          ]),
          IconButton(
            icon: Icon(
              Icons.plus_one,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () => boxCreateProvider.addNewMacroBox(customTab),
          ),
          SizedBox(height: 40),
          SizedBox(
            height: 50,
            width: 200,
            child: TextField(
              style: Theme.of(context).textTheme.bodyText1,
              controller: boxCreateProvider.actionInputController,
              decoration: InputDecoration(
                hintText: 'Macro Keys',
                fillColor: Colors.black,
                hintStyle: Theme.of(context).textTheme.bodyText1,
              ),
              textAlign: TextAlign.center,
              onChanged: (String value) {
                boxCreateProvider.setAction(value);
              },
            ),
          ),
          SizedBox(
            height: 50,
            width: 200,
            child: TextField(
              style: Theme.of(context).textTheme.bodyText1,
              controller: boxCreateProvider.pasteInputController,
              decoration: InputDecoration(
                hintText: 'Paste String or File',
                fillColor: Colors.black,
                hintStyle: Theme.of(context).textTheme.bodyText1,
              ),
              textAlign: TextAlign.center,
              onChanged: (String value) {
                boxCreateProvider.setPaste(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Action Type:',
                    style: Theme.of(context).textTheme.bodyText1),
                DropdownButton<String>(
                  //dropdownColor: Colors.grey,
                  //value: boxCreateProvider.fontSelection,
                  value: boxCreateProvider.actionSelection,
                  onChanged: (String value) {
                    boxCreateProvider.setActionSelection(value);
                  },
                  items: <String>['Macro', 'HotKey', 'Command', 'Paste']
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
          //AvailModule(boxCreateProvider)
          FlatButton(
            child: Text(
              'tap to view',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onPressed: () {
              _showDialog();
            },
          )
        ],
      ),
    );
  }
}
