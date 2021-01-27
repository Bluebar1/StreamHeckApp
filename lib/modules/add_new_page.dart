import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamheck/Providers/box_create_provider.dart';
import 'package:streamheck/Providers/macro_pages_provider.dart';

class AddNewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final macroPagesProvider = Provider.of<MacroPagesProvider>(context);
    //final boxCreateProvider = Provider.of<BoxCreateProvider>(context);
    var _list = macroPagesProvider.macroPageList;
    var _newList = _list.reversed.toList();
    var size = MediaQuery.of(context).size;
    //macroPagesProvider.startTextController();
    return SizedBox(
      height: size.height - 100,
      width: size.width - 100,
      child: Row(
        children: [
          SizedBox(
            width: size.width / 3,
            child: SizedBox(
              height: 50,
              width: 200,
              child: TextField(
                style: Theme.of(context).textTheme.bodyText2,
                controller: macroPagesProvider.newPageController,
                decoration: InputDecoration(
                  hintText: 'Enter Name Of New Page',
                  fillColor: Colors.black,
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                ),
                textAlign: TextAlign.center,
                onChanged: (String value) {
                  macroPagesProvider.setNewFileName(value);
                },
              ),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.blueAccent,
            child: FlatButton(
              onPressed: () {
                macroPagesProvider.addMacroPage(macroPagesProvider.newFileName);
                macroPagesProvider
                    .addNewPageToServer(macroPagesProvider.newFileName);
              },
              child: Text('Add new Page',
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            //child: ,
          ))
        ],
      ),
    );
  }
}
