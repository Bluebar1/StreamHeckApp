import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamheck/Providers/avail_provider.dart';
import 'package:streamheck/Providers/http_provider.dart';
import 'package:streamheck/Services/available_macro_service.dart';

class AvailMacrosPage extends StatelessWidget {
  //final HttpProvider provider;

  //AvailMacrosPage(this.provider);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AvailProvider(),
      child: Consumer<AvailProvider>(
        builder: (context, value, child) {
          return (value.availList != null)
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  width: 400,
                  child: ListView.builder(
                      itemCount: value.availList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('${value.availList[index].id}'),
                          subtitle: Text('${value.availList[index].combo}',
                              style: (value.availList[index].alreadyInUse)
                                  ? Theme.of(context).textTheme.bodyText1
                                  : Theme.of(context).textTheme.bodyText2),
                          //enabled: value.availList[index].alreadyInUse,
                        );
                      }),
                )
              : Text('loading');
        },
      ),
    );

    //var list = service.getAvailMacros()
  }
}

class CustomBuilder extends StatelessWidget {
  final HttpProvider provider;

  CustomBuilder(this.provider);

  @override
  Widget build(BuildContext context) {
    return (provider.availMacroList != null)
        ? Text('${provider.availMacroList.length}')
        : Text('loading');
  }
}
