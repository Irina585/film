import 'package:film/domain/models/film_card_model.dart';
import 'package:film/components/general_classes.dart';
import 'package:film/presentation/film_list.dart';
import 'package:film/components/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterFilmsWidget extends StatefulWidget {
  static const String routeName = '/filterFilmsWidget';

  const FilterFilmsWidget({Key? key}) : super(key: key);

  @override
  _FilterFilmsWidgetState createState() => _FilterFilmsWidgetState();
}

class _FilterFilmsWidgetState extends State<FilterFilmsWidget> {
  final _language = Language.russian.toPrettyString;
  bool _checkedRus = false;
  bool _checkedEn = false;

  double size = 5;

  var filterFilms = <FilmCardModel>[];

  void _search() {
    if (_checkedRus == true || _checkedRus == true) {
      filterFilms = FilmList.films.where((element) {
        return element.language.contains(_language.toString());
      }).toList();
    } else {
      filterFilms = FilmList.films;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _search();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.titleAppFilter),
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
                    Text('Язык',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
                CheckboxListTile(
                    title: const Text('Русский'),
                    value: _checkedRus,
                    onChanged: (val) {
                      setState(() {
                        _checkedRus = !_checkedRus;
                      });
                    }),
                CheckboxListTile(
                    title: const Text('Английский'),
                    value: _checkedEn,
                    onChanged: (val) {
                      setState(() {
                        _checkedEn = !_checkedEn;
                      });
                    }),
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
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      _search();
                      Navigator.pop(context, '/homePage');
                    },
                    child: const Text('Поиск'))
              ],
            ),
          ),
        ));
  }
}
