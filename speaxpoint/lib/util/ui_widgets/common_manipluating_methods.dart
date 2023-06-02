import 'package:drop_down_list/model/selected_list_item.dart';

List<SelectedListItem> generateSelectedListItems(
    {required List<String> choices, required List<int> indexes}) {
  List<SelectedListItem> tempList = [];
  for (int i = 0; i < choices.length; i++) {
    tempList.add(SelectedListItem(
      name: choices[i],
      value: indexes[i].toString(),
    ));
  }
  return tempList;
}
