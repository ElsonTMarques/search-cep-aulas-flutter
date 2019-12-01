import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:via_cep/blocs/theme.dart';
import 'package:via_cep/models/result_cep.dart';
import 'package:via_cep/services/via_cep_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _fetching = false;

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar CEP'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.highlight),
            tooltip: 'Change theme',
            onPressed: () {
              _themeChanger.setIsDark(!_themeChanger.getIsDark());
              if (_themeChanger.getIsDark()) {
                _themeChanger.setTheme(ThemeData.dark());
                _themeChanger.setIcon(Icons.highlight);
              } else {
                _themeChanger.setTheme(ThemeData.light());
                _themeChanger.setIcon(Icons.lightbulb_outline);
              }    
            } 
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: _buildForm(),
      ),
      
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildTextField(),
        _buildRaisedButton()
      ],
    );
  }

  var _searchController = TextEditingController();

  Padding _buildTextField() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0
      ),
      child: TextField(
        controller: _searchController,
      ),
    );
  } 

  RaisedButton _buildRaisedButton() {
    return RaisedButton(
        child: _fetching
          ? Container(
            height: 15.0,
            width: 15.0,
            child: CircularProgressIndicator(),
          )
          : Text('Consultar'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        onPressed: () async {
          setState(() {
            _fetching = true;
          });

          ResultCep resultCep = await ViaCepService.fetchCep(
            cep: _searchController.text
          );
          print(resultCepToJson(resultCep));

          setState(() {
            _fetching = false;
          });
        },
      );
  }
}