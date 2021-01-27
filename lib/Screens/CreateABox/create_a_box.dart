import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamheck/Providers/box_create_provider.dart';
import 'package:streamheck/Providers/http_provider.dart';
import 'package:streamheck/Screens/CreateABox/left.dart';
import 'package:streamheck/Screens/CreateABox/middle.dart';
import 'package:streamheck/Screens/CreateABox/right.dart';
import 'package:streamheck/Screens/contacts.dart';

/*
Created NB 5/2020


*/

class CreateABox extends StatelessWidget {
  final String customTab;
  final HttpProvider httpProvider;

  CreateABox(this.httpProvider, this.customTab);
  @override
  Widget build(BuildContext context) {
    String convertToFileFormat(String page) {
      // String _tempString = page;
      // _tempString
      return page.replaceAll(' ', '_').toLowerCase() + '.json';
    }

    var boxCreateProvider = Provider.of<BoxCreateProvider>(context);
    //var httpProvider = HttpProvider('');
    void _pop() {
      //httpProvider.runHttpReq();
      print('POP WAS CALLED ON CUSTOM TAB :: ' + customTab);
      httpProvider.runHttpReq(convertToFileFormat(customTab), 'pages');
      Navigator.pop(context);
      boxCreateProvider.wipe();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pop(),
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Left(boxCreateProvider),
          ),
          VerticalDivider(width: 0, color: Colors.white),
          Middle(boxCreateProvider, customTab),
          VerticalDivider(width: 0, color: Colors.white),
          Right(boxCreateProvider),
        ],
      ),
    );
  }
}
