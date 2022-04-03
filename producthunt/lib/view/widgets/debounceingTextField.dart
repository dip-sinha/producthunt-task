import 'dart:async';

import 'package:flutter/material.dart';
import 'package:producthunt/view/resources/palette.dart';

class DebouncingTextField extends StatefulWidget {
  final FocusNode? focusNode;

  /// The initial text to be filled in the search bar
  final String? initValue;

  /// This is called once the user completes a typing or a clearing action
  ///
  /// Has one parameter `query` which will give the current text present in the TextField
  ///
  /// This function is called with a debounce based on [debounceDuration]
  final void Function(String query)? onSearch;

  /// The debounce duration for all user actions like typing and clearing text
  ///
  /// The [onSearch] function is called after waiting for this much duration during which no action has been performed
  ///
  /// Defaults to `const Duration(milliseconds: Constants.searchDebounceInMillis)`
  final Duration debounceDuration;

  /// The placeholder text to be shown in the input
  final String? hint;

  /// To enable or disable the search field
  ///
  /// Defaults to true
  final bool enabled;

  /// Whether to auto focus the TextField
  ///
  /// Default to false
  final bool autoFocus;

  final TextEditingController? textEditingController;

  DebouncingTextField({
    this.hint,
    this.focusNode,
    this.onSearch,
    this.initValue,
    this.debounceDuration =
    const Duration(milliseconds: 300),
    this.enabled = true,
    this.autoFocus = false,
    this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  _DebouncingTextFieldState createState() =>
      _DebouncingTextFieldState(initValue, textEditingController);
}

class _DebouncingTextFieldState extends State<DebouncingTextField> {
  Timer? debounce;
  late final TextEditingController controller;

  bool clearIconVisible = false;

  _DebouncingTextFieldState(
      String? init, TextEditingController? textEditingController) {
    controller = (textEditingController ?? TextEditingController(text: init));

    // controller = (textEditingController ?? TextEditingController(text: init))
    //   ..addListener(() {
    //     handleChange();
    //     setState(() => clearIconVisible = controller.text.isNotEmpty);
    //   });
  }

  void handleChange() {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(
      widget.debounceDuration,
          () => widget.onSearch!(controller.text),
    );
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 1.5),
              child: TextField(
                autofocus: widget.autoFocus,
                focusNode: widget.focusNode,
                enabled: widget.enabled,
                style: const TextStyle( fontSize: 14),
                textInputAction: TextInputAction.search,
                controller: controller,
                onSubmitted: widget.onSearch,
                onChanged: (text) {
                  handleChange();
                  setState(() => clearIconVisible = text.isNotEmpty);
                },
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: TextStyle(color: Colors.black.withOpacity(.2), fontSize: 14),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          if (clearIconVisible)
            IconButton(
              iconSize: 20,
              splashRadius: 16,
              onPressed: () {
                controller.clear();
                handleChange();
                setState(() => clearIconVisible = false);
                // widget.onSearch!("");
              },
              visualDensity: VisualDensity.compact,
              icon: Icon(Icons.cancel_rounded, color: Colors.black.withOpacity(0.5)),
            ),
        ],
      ),
    );
  }
}
