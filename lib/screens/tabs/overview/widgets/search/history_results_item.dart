import 'package:flutter/material.dart';

class HistoryResultItem extends StatelessWidget {
  const HistoryResultItem({
    Key key,
    @required this.onTap,
    @required this.delete,
    @required this.title,
  }) : super(key: key);

  final Function onTap;
  final Function delete;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      leading: const Icon(Icons.history),
      title: Text(title),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever),
        onPressed: delete,
      ),
    );
  }
}
