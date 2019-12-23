import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:video_chat/snack.dart';

class InternationalizationPage extends StatefulWidget {
  @override

  I18n createState() => I18n();
}

class I18n extends State<InternationalizationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(FlutterI18n.translate(context, 'app.settings')),
      ),
      body: Builder(builder: (BuildContext context) {
        BuildContext scaffoldContext = context;
        return ListView(
          children: <Widget>[
            ListTile(  
              title: Text('English'),
              onTap: () {
                Locale newLocale = Locale('en');
                setState(() {
                  FlutterI18n.refresh(context, newLocale);
                  snack(scaffoldContext, 'Language Changed to English');
                });
              }, 
            ),
            ListTile( 
              title: Text('Français'),
              onTap: () {
                Locale newLocale = Locale('fr');
                setState(() {
                  FlutterI18n.refresh(context, newLocale);
                  snack(scaffoldContext, 'Langue Changée en Français');
                });
              }, 
            ),
            ListTile(  
              title: Text('Español'),
              onTap: () {
                Locale newLocale = Locale('es');
                setState(() {
                  FlutterI18n.refresh(context, newLocale);
                  snack(scaffoldContext, 'Idioma Cambiado a Español');
                });
              }, 
            ),
          ],
        );
      }),
    );
  }

}