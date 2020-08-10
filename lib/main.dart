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
      appBar: AppBar(
          title: Text("Hello".i18n),
        centerTitle: false,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            RadioListTile(
              groupValue: 0,
              value: 'english',
              selected: !provider.getRTL,
              title: Text("English"),
              onChanged: (val) {
                provider.setLanguage(Locale('en', 'EN'));
                provider.setRTL(false);
                I18n.of(context).locale = Locale("en", 'US');
              },
            ),
            RadioListTile(
              selected: provider.getRTL,
              groupValue: 0,
              value: 'arabic',
              title: Text("Arabic"),
              onChanged: (val){
                provider.setLanguage(Locale('ar', 'AR'));
                I18n.of(context).locale = Locale("ar", 'AR');
                provider.setRTL(true);
              },
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Text("Hello, how are you?".i18n),
              Text("Hi".i18n)
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.language),
        onPressed: (){
          print(I18n.of(context).locale);

        },
      ),
    );
  }
}
