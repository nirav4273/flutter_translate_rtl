import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_tranlate_theme/store/config.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:provider/provider.dart';
import 'i18n/i18n.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConfigProvider(),
        )
      ],
      child: MainApp(),
    )
  );
}

class MainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ConfigProvider provider =   Provider.of<ConfigProvider>(context);
    Locale locale = provider.getLanguage;
    final isRTL = provider.getRTL;

    print(locale);
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', "US"),
        const Locale('ar', "AR"),
      ],
      home: I18n(
        initialLocale: locale,
        child: Directionality(
          child: Home(),
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        ),
      ),
    );
  }
}

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ConfigProvider provider = Provider.of(context, listen: false);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Hello".i18n)),
      drawer: Drawer(
        child: Column(
          children: [
            CheckboxListTile(
              value: !provider.getRTL,
              title: Text("English"),
            ),
            CheckboxListTile(
              value: provider.getRTL,
              title: Text("Arabic"),
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Text("HEllo"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.language),
        onPressed: (){
          print(I18n.of(context).locale);
          if(I18n.of(context).locale.countryCode == 'AR') {
            I18n.of(context).locale = Locale("en", 'US');
            provider.setRTL(false);
          } else {
            provider.setRTL(true);
            I18n.of(context).locale = Locale("ar", 'AR');
          }
        },
      ),
    );
  }
}
