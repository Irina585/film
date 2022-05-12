import 'package:film/bloc/home_bloc/film_list.dart';
import 'package:film/components/buttons/widget/button_base.dart';
import 'package:film/components/buttons/scale_button.dart';
import 'package:film/components/buttons/type_button.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/presentation/pages/film_detail_grid_page.dart';
import 'package:flutter/material.dart';

// вёрстка карточки фильма - Grid

class FilmCard extends StatefulWidget {
  const FilmCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.picture,
      required this.voteAverage,
      required this.releaseDate,
      required this.description,
      required this.icon})
      : super(key: key);

  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final Icon icon;

  factory FilmCard.fromModel({
    required FilmCardModel model,
    Key? key,
  }) {
    return FilmCard(
      id: model.id,
      title: model.title,
      picture: model.picture,
      voteAverage: model.voteAverage,
      releaseDate: model.releaseDate,
      description: model.description,
      icon: model.icon,
      key: key,
    );
  }

  @override
  _FilmCardState createState() => _FilmCardState();
}

class _FilmCardState extends State<FilmCard> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 2,
                offset: Offset(1, 2),
                spreadRadius: 2,
                color: Colors.grey),
          ]),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.picture,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 8,
            child: BaseButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FilmDetailGridePage(),
                        settings: RouteSettings(
                          arguments: FilmList.films
                              .firstWhere((element) => element.id == widget.id),
                        )),
                  );
                },
                type: ButtonType.primary,
                scale: ButtonScale.small,
                child: const Text('More')),
          )
        ],
      ),
    );
  }
}
