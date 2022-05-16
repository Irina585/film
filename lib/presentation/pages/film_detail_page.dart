import 'package:cached_network_image/cached_network_image.dart';
import 'package:film/app/components/buttons/base_button/scale_button.dart';
import 'package:film/app/components/buttons/base_button/type_button.dart';
import 'package:film/app/components/buttons/base_button/widget/button_base.dart';
import 'package:film/app/components/const.dart';
import 'package:film/domain/models/film_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilmDetailPage extends StatelessWidget {
  static const String routeName = '/filmDetailTilePage';

  final FilmCardModel? filmCardModel;

  const FilmDetailPage({
    Key? key,
    this.filmCardModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${filmCardModel?.title}'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)])),
        child: ListView(
          children: [
            CachedNetworkImage(
              imageUrl: '${filmCardModel?.picture}',
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) =>
                  Image.network(FilmQuery.pisecImageUrl),
              cacheManager: FilmPictures.pictureCache,
            ),
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff374ABE), Color(0xff64B6FF)])),
              height: 170,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Text('${filmCardModel?.title}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white)),
                  const SizedBox(height: 5),
                  Text('${filmCardModel?.releaseDate}',
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 17, color: Colors.white)),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${filmCardModel?.voteAverage}'.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 17,
                              color: Colors.white)),
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.star, color: Colors.yellow),
                      ),
                    ],
                  ),
                  BaseButton(
                    type: ButtonType.primary,
                    scale: ButtonScale.medium,
                    child: const Text('Смотреть фильм'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  const SizedBox(width: 15),
                  Text('${filmCardModel?.description}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.justify)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
