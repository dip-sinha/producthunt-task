import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:producthunt/view/resources/asset_constants.dart';
import 'package:producthunt/view/resources/palette.dart';

import 'debounceingTextField.dart';

class SearchCard extends StatelessWidget {
  final FocusNode? focusNode;

  /// The placeholder to be shown in the TextField
  ///
  /// Defaults to `Search`
  final String? hint;

  /// This callback is triggered once the user completes his actions and the debounce time has been completed
  ///
  /// Has one parameter which is the current text inside the TextField at the time of callback
  final Function(String query)? onSearch;

  /// A List of widgets to be displayed at the start of this widget
  ///
  /// Defaults to a List containing a single Search Icon
  final List<Widget>? leading;

  /// A List of widgets to be displayed at the end of this widget
  final List<Widget>? trailing;

  /// Margin for the Material Card widget
  ///
  /// Defaults to `EdgeInsets.zero`
  final EdgeInsets? margin;

  /// Whether to auto focus the Search Debouncing TextField
  ///
  /// Default to false
  final bool autoFocus;

  final TextEditingController? textEditingController;
  final Duration debounceDuration;

  SearchCard({
    this.focusNode,
    this.onSearch,
    this.hint,
    this.leading,
    this.trailing,
    this.margin = EdgeInsets.zero,
    this.autoFocus = false,
    this.textEditingController,
    this.debounceDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    final leading = this.leading ??
        [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(AssetConstants.icSearch,height: 22, width: 22,color: Colors.black.withOpacity(.5),),
          )
        ];

    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: Palette.searchBarColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(96, 97, 112, 0.16),
              blurRadius: 2,
              offset: Offset(0, 0.5),
            ),
            BoxShadow(
              color: Color.fromRGBO(40, 41, 61, 0.08),
              blurRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          ...leading,
          if (leading.isEmpty) SizedBox(width: 11.32),
          Expanded(
            child: DebouncingTextField(
              autoFocus: autoFocus,
              focusNode: focusNode,
              hint: hint ?? 'Search',
              onSearch: onSearch,
              textEditingController: textEditingController,
              debounceDuration: debounceDuration,
            ),
          ),
          ...?trailing,
        ],
      ),
    );
  }
}