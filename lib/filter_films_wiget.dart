import 'package:film/film_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterFilmsWidget extends StatefulWidget {
  static const String routeName = '/filterFilmsWidget.dart';

  const FilterFilmsWidget({Key? key}) : super(key: key);

  @override
  _FilterFilmsWidgetState createState() => _FilterFilmsWidgetState();
}

class _FilterFilmsWidgetState extends State<FilterFilmsWidget> {
  Language? _language = Language.russian;
  double size = 5;


  void _onLanguageChange(Language? value) {
    setState(() {
      _language = value;
    });
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Фильтр фильмов'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('Язык', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
                RadioListTile(
                  activeColor: Theme.of(context).colorScheme.primary,
                  dense: true,
                  title: const Text('Русский', style: TextStyle(fontSize: 17)),
                  value: Language.russian,
                  groupValue: _language,
                  onChanged: _onLanguageChange,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                RadioListTile(
                  activeColor: Theme.of(context).colorScheme.primary,
                  dense: true,
                  title: const Text('Английский', style: TextStyle(fontSize: 17)),
                  value: Language.english,
                  groupValue: _language,
                  onChanged: _onLanguageChange,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                const Text('Рейтинг', style: TextStyle(fontSize: 17)),
                SfSlider(
                    min: 0,
                    max: 10,
                    interval: 2,
                    showTicks: true,
                    showLabels: true,
                    value: size,
                    enableTooltip: false,
                    minorTicksPerInterval: 0,
                    stepSize: 1,
                    onChanged: (dynamic value) {
                      setState(() {
                        size = value;
                      });
                    }),
              ],
            ),
          ),
        ));
  }
}
