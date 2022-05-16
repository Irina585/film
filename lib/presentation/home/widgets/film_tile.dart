import 'package:cached_network_image/cached_network_image.dart';
import 'package:film/app/components/buttons/primary_button/primary_button.dart';
import 'package:film/app/components/const.dart';
import 'package:film/app/components/locals/locals.dart';
import 'package:film/app/components/theme_text.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:film/presentation/navigation/bloc/navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// вёрстка карточки фильма - List

class FilmTile extends StatelessWidget {
  final FilmCardModel? filmCardModel;
  final VoidCallback? onClickFavoriteButton;
  final String textButton;

  const FilmTile(
      {Key? key,
      this.filmCardModel,
      this.onClickFavoriteButton,
      required this.textButton})
      : super(key: key);

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
              context.read<NavigationBloc>().add(PressedOnFilmDetailTilePage());
            },
            /*
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FilmDetailsTilePage(),
                    settings: RouteSettings(
                      arguments: FilmList.films.firstWhere(
                          (element) => element.id == widget.filmCardModel?.id),
                    )),
              );
            },*/
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: '${filmCardModel?.picture}',
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
                                  'Название: ${filmCardModel?.title}',
                                  style: boldTextStyle,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                    'Дата выхода: ${filmCardModel?.releaseDate}',
                                    style: mainTextStyle),
                                const SizedBox(height: 3),
                                Text('Язык: ${filmCardModel?.language}',
                                    style: mainTextStyle),
                                const SizedBox(height: 3),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 10),
                                  child: PrimaryButton(
                                    textButton,
                                    onPressed: () {
                                      onClickFavoriteButton?.call();
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _rating(context,
                                            filmCardModel?.voteAverage ?? 0),
                                        style: const TextStyle(fontSize: 16),
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

  String _rating(BuildContext context, double voteAverage) {
    final prefix = context.locale.ratingPrefix;
    final suffix = context.locale.ratingSuffix;
    final rating = (voteAverage * 10).toInt();
    return '$prefix $rating $suffix';
  }
}
