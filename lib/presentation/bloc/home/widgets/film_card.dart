import 'package:cached_network_image/cached_network_image.dart';
import 'package:film/components/buttons/widget/button_base.dart';
import 'package:film/components/buttons/scale_button.dart';
import 'package:film/components/buttons/type_button.dart';
import 'package:film/components/const.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:film/presentation/bloc/detail/film_detail_tile_page.dart';
import 'package:film/presentation/bloc/home/film_list.dart';
import 'package:flutter/material.dart';

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FilmDetailTilePage(),
                        settings: RouteSettings(
                          arguments: FilmList.films.firstWhere((element) =>
                              element.id == widget.filmCardModel?.id),
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
