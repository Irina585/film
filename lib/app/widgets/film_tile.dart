import 'package:film/app/models/film_card_model.dart';
import 'package:film/feauters/home/pages/film_detail_page.dart';
import 'package:film/feauters/home/widgets/film_list.dart';
import 'package:flutter/material.dart';

import '../../strings.dart';

// вёрстка карточки фильма - List
class FilmTile extends StatefulWidget {
  const FilmTile(
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

  factory FilmTile.fromModel({
    required FilmCardModel model,
    Key? key,
  }) {
    return FilmTile(
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
  State<FilmTile> createState() => _FilmTileState();
}

class _FilmTileState extends State<FilmTile> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2))
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FilmDetailsPage(),
                    settings: RouteSettings(
                      arguments: FilmList.films
                          .firstWhere((element) => element.id == widget.id),
                    )),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                      widget.picture,
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
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            widget.title,
                            style: Theme.of(context).textTheme.headline6,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Дата выхода: ${widget.releaseDate}',
                            style: const TextStyle(color: Colors.grey),
                            textAlign: TextAlign.start,
                          ),
                          Text(widget.description,
                              maxLines: 3, overflow: TextOverflow.ellipsis),
                          Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.star, color: Colors.yellow),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      widget.voteAverage.toStringAsFixed(1),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: widget.voteAverage < 4
                                              ? Colors.red
                                              : widget.voteAverage >= 8
                                                  ? Colors.green
                                                  : Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 150,
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        icon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: (_isFavorited
                                              ? const Icon(Icons.favorite)
                                              : const Icon(
                                                  Icons.favorite_border)),
                                        ),
                                        color: Colors.red[500],
                                        onPressed: _toggleFavorite,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
