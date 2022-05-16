import 'package:cached_network_image/cached_network_image.dart';
import 'package:film/app/components/buttons/base_button/scale_button.dart';
import 'package:film/app/components/buttons/base_button/type_button.dart';
import 'package:film/app/components/buttons/base_button/widget/button_base.dart';
import 'package:film/app/components/const.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:film/presentation/navigation/bloc/navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// вёрстка карточки фильма - Grid

class FilmCard extends StatefulWidget {
  final FilmCardModel? filmCardModel;

  const FilmCard({Key? key, this.filmCardModel}) : super(key: key);

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
              child: CachedNetworkImage(
                imageUrl: '${widget.filmCardModel?.picture}',
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Image.network(FilmQuery.pisecImageUrl),
                cacheManager: FilmPictures.pictureCache,
              ),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 8,
            child: BaseButton(
                onPressed: () {
                  context
                      .read<NavigationBloc>()
                      .add(PressedOnFilmDetailTilePage());
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
