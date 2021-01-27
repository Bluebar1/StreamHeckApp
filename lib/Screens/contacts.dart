import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamheck/Providers/http_provider.dart';
import 'package:streamheck/Providers/macro_pages_provider.dart';
import 'package:streamheck/Providers/socket_server_provider.dart';
import 'package:streamheck/Screens/CreateABox/create_a_box.dart';
import 'package:streamheck/Screens/avail_macros_page.dart';
import 'package:streamheck/Screens/macro_screen.dart';
import 'package:streamheck/modules/action_tile.dart';
import 'package:streamheck/modules/add_new_page.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  //final _contacts = _data();
  final _selection = ValueNotifier<String>(null);
  double kTabletBreakpoint = 720.0;
  double kDesktopBreakpoint = 1440.0;
  @override
  Widget build(context) {
    print('CONTACT SCREEN BEING BUILT ))))))))))))))))');
    Provider.of<SocketServerProvider>(context);
    var macroPagesProvider = Provider.of<MacroPagesProvider>(context);
    
    return LayoutBuilder(builder: (context, dimens) {
      if (dimens.maxWidth >= kTabletBreakpoint) {
        const kListViewWidth = 300.0;
        return Row(
          children: <Widget>[
            Container(
              width: kListViewWidth,
              child: buildListView(macroPagesProvider, (val) {
                _selection.value = val;
              }),
            ),
            VerticalDivider(width: 0),
            Expanded(
                child: ValueListenableBuilder<String>(
              valueListenable: _selection,
              builder: (context, contact, child) {
                print('LAYOUT BUILDER IS BEING REBUILT ===============');
                print('contact : $contact ' + 'selection : $_selection');
                if (contact == null) {
                  return Scaffold(
                    floatingActionButton: FloatingActionButton(
                      foregroundColor: Colors.white,
                      onPressed: () {
                        print('pressed ');
                      },
                    ),
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      backgroundColor: Color.fromRGBO(60, 60, 60, 1),
                    ),
                    body: Center(child: MacroScreen()),
                  );
                }
                return CustomTabDetails(tab: contact);
              },
            ))
          ],
        );
      }
      return buildListView(macroPagesProvider, (val) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CustomTabDetails(tab: val),
          ),
        );
      });
    });
  }

  void _showDialog(MacroPagesProvider macroPagesProvider) {
    macroPagesProvider.newPageController.clear();
    // flutter defined function
    showDialog(
        context: context,
        builder: (context) {
          // return object of type Dialog
          return AlertDialog(
              title: Text("Edit Pages"),
              content: AddNewPage(),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                FlatButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  Widget buildListView(
      MacroPagesProvider macroPagesProvider, ValueChanged<String> onSelect) {
    var _list = macroPagesProvider.macroPageList;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: false,
          title: Text('Contacts'),
          backgroundColor: Color.fromRGBO(60, 60, 60, 1),
          actions: [
            IconButton(
                icon: Icon(Icons.ac_unit),
                color: Colors.white,
                iconSize: 30,
                onPressed: () =>
                    _showDialog(macroPagesProvider) //_startCreateABox(value),
                ),
          ],
        ),
        body: ReorderableListView(
          padding: EdgeInsets.only(bottom: 50),
          reverse: true,
          onReorder: (oldIndex, newIndex) =>
              macroPagesProvider.reorderPages(oldIndex, newIndex),
          children: [
            for (String page in _list)
              GestureDetector(
                key: ValueKey(_list.indexOf(page)),
                onTap: () => onSelect(page), //print(_list.indexOf(page)),
                child: ListTile(
                  key: ValueKey(_list.indexOf(page)),
                  title: Text(
                    '$page',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              )
          ],
        )

        // body: ListView.separated(
        //   reverse: true,
        //   separatorBuilder: (context, index) => Divider(height: 0),
        //   itemCount: _list.length, //_contacts.length,
        //   itemBuilder: (context, index) {
        //     //final _contact = _list[index];
        //     return ListTile(
        //       leading: Icon(Icons.person),
        //       title: Text(
        //         _list[index],
        //         style: Theme.of(context).textTheme.bodyText1,
        //       ),
        //       //subtitle: Text(_contact.email),
        //       onTap: () => onSelect(_list[index]),
        //     );
        //   },
        // ),
        );
  }
}

class CustomTabDetails extends StatelessWidget {
  String convertToFileFormat(String page) {
    // String _tempString = page;
    // _tempString
    return page.replaceAll(' ', '_').toLowerCase() + '.json';
  }

  final String tab;
  

  const CustomTabDetails({
    Key key,
    @required this.tab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _startCreateABox(HttpProvider httpProvider) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateABox(httpProvider, tab)),
      );
    }

    void _openAvailMacros(HttpProvider httpProvider) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Scaffold(body: AvailMacrosPage())));
    }

    print('CUSTOM TAB DETAILS BEING REBUILT');
    print('TAB ::: ' + tab);
    return ChangeNotifierProvider.value(
      value: HttpProvider(convertToFileFormat(tab), 'pages'),
      child: Consumer<HttpProvider>(
        builder: (context, value, child) {
          return (value.macroList != null)
              ? Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    title: Text('Details'),
                    centerTitle: false,
                    backgroundColor: Color.fromRGBO(60, 60, 60, 1),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.ac_unit),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () => _startCreateABox(value),
                      ),
                      IconButton(
                        icon: Icon(Icons.dashboard),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () => _openAvailMacros(value),
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: GridView.builder(
                        reverse: true,
                        itemCount: value.macroList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ActionTile(tab, index, value),
                          );
                        }),
                  ))
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Color.fromRGBO(60, 60, 60, 1),
                  ),
                  backgroundColor: Colors.black,
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        },
      ),
    );

    ;
  }
}

List<Contact> _dummyData() {
  return [
    Contact('John Doe', 'john@app.com'),
    Contact('Susan Smith', 'susan@gmail.com'),
    Contact('James Hatfield', 'james.hatfield@yahoo.com'),
    Contact('Steve Jobs', 'steve@apple.com'),
    Contact('Bill Gates', 'gates@microsoft.com'),
    Contact('Elon Musk', 'elon@tesla.com'),
    Contact('John Smith', 'smith77@me.com'),
  ];
}

List<CustomTab> _data() {
  return [
    CustomTab('Paste', 'macros.json'),
    CustomTab('Windows Keys', 'windows_keys.json'),
    CustomTab('Flutter paste', 'flutter_paste.json')
  ];
}

class CustomTab {
  final String title;
  final String fileName;

  CustomTab(this.title, this.fileName);
}

class Contact {
  final String name;
  final String email;

  Contact(this.name, this.email);
}
