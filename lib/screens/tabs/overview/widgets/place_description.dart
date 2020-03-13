import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/description_model.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:provider/provider.dart';

class PlaceDescription extends StatelessWidget {
  final DescriptionVM description;
  PlaceDescription(this.description);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context, listen: false).locale;
    return MyCard(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                description
                    ?.getDescription(lang ?? Localizations.localeOf(context)),
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
