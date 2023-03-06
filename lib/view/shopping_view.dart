import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopping/model/shopping_card_model.dart';
import 'package:provider_shopping/product/paddings.dart';
import 'package:provider_shopping/product/strings.dart';
import 'package:provider_shopping/provider/shopping_provider.dart';
import 'package:provider_shopping/view/favorite_list_view.dart';

class ShoppingView extends StatefulWidget {
  const ShoppingView({Key? key}) : super(key: key);

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  @override
  Widget build(BuildContext context) {
    var shoppingList = context.watch<ShoppingProvider>().shoppingList;
    var saveList = context.watch<ShoppingProvider>().saveList;
    return Scaffold(
      appBar: AppBar(
        title:  Text(ProjectStrings().appName),
        actions: [
          _AppbarElevatedButton(saveList: saveList),
        ],
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
            final currentCard = shoppingList[index];
            return _GridTileWidget(saveList: saveList, currentCard: currentCard,);
          },
          itemCount: shoppingList.length,
        ),
      ),
    );
  }
}

class _GridTileWidget extends StatelessWidget {
  const _GridTileWidget({
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
    required this.saveList,
  });

  final List<ShoppingCardModel> saveList;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const FavoriteListView()));
      },
      icon: const Icon(
        Icons.favorite,
        color: Colors.red,
        size: 20,
      ),
      label: Text(
        "${saveList.length}",
        style: const TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
