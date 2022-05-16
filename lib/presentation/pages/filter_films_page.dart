import 'package:film/app/components/buttons/base_button/scale_button.dart';
import 'package:film/app/components/buttons/base_button/type_button.dart';
import 'package:film/app/components/buttons/base_button/widget/button_base.dart';
import 'package:film/app/components/const.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterFilmsWidget extends StatefulWidget {
  static const String routeName = '/filterFilmsWidget';

  const FilterFilmsWidget({Key? key}) : super(key: key);

  @override
  _FilterFilmsWidgetState createState() => _FilterFilmsWidgetState();
}

class _FilterFilmsWidgetState extends State<FilterFilmsWidget> {
  bool _checkedRus = false;
  bool _checkedEn = false;

  double size = 5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(FilmLocal.titleAppFilter),
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
                BaseButton(
                  type: ButtonType.primary,
                  scale: ButtonScale.medium,
                  child: const Text('Поиск'),
                  onPressed: () {
                    Navigator.pop(context, '/homePage');
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
