import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopping/model/shopping_card_model.dart';
import 'package:provider_shopping/product/strings.dart';
import 'package:provider_shopping/provider/shopping_provider.dart';

import '../product/paddings.dart';

class FavoriteListView extends StatefulWidget {
  const FavoriteListView({Key? key}) : super(key: key);

  @override
  State<FavoriteListView> createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView> {
  @override
  Widget build(BuildContext context) {
    final saveList = context.watch<ShoppingProvider>().saveList;
    return Scaffold(
      appBar: AppBar(
        title: Text(ProjectStrings().favListViewName),
        leading: const _AppbarElevatedButton(),
      ),
      body: Padding(
        padding: ProjectPaddings().generalPadding,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (_, index) {
            final currentCard = saveList[index];
            return _GridTileWidget(saveList: saveList, currentCard: currentCard);
          },
          itemCount: saveList.length,
        ),
      ),
    );
  }
}

class _GridTileWidget extends StatelessWidget {
  const _GridTileWidget({
    super.key,
    required this.saveList,
    required this.currentCard,
  });

  final List<ShoppingCardModel> saveList;
  final ShoppingCardModel currentCard;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: GridTileBar(
        leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: saveList.contains(currentCard)
                  ? Colors.red
                  : Colors.white,
              size: 25,
            ),
            onPressed: () {
              if (!saveList.contains(currentCard)) {
                context.read<ShoppingProvider>().addToList(currentCard);
              } else {
                context
                    .read<ShoppingProvider>()
                    .removeFromList(currentCard);
              }
            }),
      ),
      footer: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: ProjectPaddings().footerPadding,
              child: Text(
                currentCard.brand ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: ProjectPaddings().footerPadding,
              child: Text(
                currentCard.money ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      child: Image.network(currentCard.url ?? ''),
    );
  }
}

class _AppbarElevatedButton extends StatelessWidget {
  const _AppbarElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_outlined,
        color: Colors.black54,
        size: 20,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      label: const Text(''),
    );
  }
}
