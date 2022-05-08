import 'package:cached_network_image/cached_network_image.dart';
import 'package:film/components/const.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/presentation/film_list.dart';
import 'package:film/presentation/pages/film_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

// вёрстка карточки фильма - List

class FilmTile extends StatefulWidget {
  final FilmCardModel? filmCardModel;

  const FilmTile({Key? key, this.filmCardModel}) : super(key: key);

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
                      arguments: FilmList.films.firstWhere(
                          (element) => element.id == widget.filmCardModel?.id),
                    )),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: '${widget.filmCardModel?.picture}',
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) =>
                        Image.network(FilmQuery.pisecImageUrl),
                    cacheManager: FilmPictures.pictureCache,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Название: ${widget.filmCardModel?.title}',
                                  style: boldTextStyle,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                    'Дата выхода: ${widget.filmCardModel?.releaseDate}',
                                    style: mainTextStyle),
                                const SizedBox(height: 3),
                                Text('Язык: ${widget.filmCardModel?.language}',
                                    style: mainTextStyle),
                                const SizedBox(height: 3),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 10),
                                  child: Html(
                                    data:
                                        widget.filmCardModel?.description ?? '',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _rating(
                                            widget.filmCardModel?.voteAverage ??
                                                0),
                                        style: const TextStyle(fontSize: 16),
                                      ),
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
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _rating(double voteAverage) {
  const prefix = FilmLocal.ratingPrefix;
  const suffix = FilmLocal.ratingSuffix;
  final rating = (voteAverage * 10).toInt();
  return '$prefix $rating $suffix';
}
