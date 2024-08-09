import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';

typedef OnOptionSelected<T> = void Function(List<ValueItem<T>> selectedOptions);

class MultiSelectDropDown<T> extends StatefulWidget {
  // selection type of the dropdown
  final SelectionType selectionType;

  // Hint
  final String hint;
  final Color? hintColor;
  final double? hintFontSize;
  final TextStyle? hintStyle;

  // Options
  final List<ValueItem<T>> options;
  final List<ValueItem<T>> selectedOptions;
  final List<ValueItem<T>> disabledOptions;
  final OnOptionSelected<T>? onOptionSelected;

  // selected option
  final Icon? selectedOptionIcon;
  final Color? selectedOptionTextColor;
  final Color? selectedOptionBackgroundColor;
  final Widget Function(BuildContext, ValueItem<T>)? selectedItemBuilder;

  // chip configuration
  final bool showChipInSingleSelectMode;
  final ChipConfig chipConfig;

  // options configuration
  final Color? optionsBackgroundColor;
  final TextStyle? optionTextStyle;
  final double dropdownHeight;
  final Widget? optionSeparator;
  final bool alwaysShowOptionIcon;

  // dropdownfield configuration
  final Color? backgroundColor;
  final Widget? suffixIcon;
  final Icon? clearIcon;
  final Decoration? inputDecoration;
  final double? borderRadius;
  final BorderRadiusGeometry? radiusGeometry;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final RxBool isErroShow;
  final double? borderWidth;
  final double? focusedBorderWidth;
  final EdgeInsets? padding;
  final bool showClearIcon;
  final int? maxItems;

  // dropdown border radius
  final double? dropdownBorderRadius;
  final double? dropdownMargin;
  final bool isShowOutSideTap;
  final bool isEnable;

  // network configuration
  // final NetworkConfig? networkConfig;
  final Future<List<ValueItem<T>>> Function(dynamic)? responseParser;
  final Widget Function(BuildContext, dynamic)? responseErrorBuilder;

  /// focus node
  final FocusNode? focusNode;

  /// Controller for the dropdown
  /// [controller] is the controller for the dropdown. It can be used to programmatically open and close the dropdown.
  final MultiSelectController<T>? controller;

  /// Enable search
  /// [searchEnabled] is the flag to enable search in dropdown. It is used to show search bar in dropdown.
  final bool searchEnabled;
  final Color? searchBackgroundColor;

  /// Search label
  /// [searchLabel] is the label for search bar in dropdown.
  final String? searchLabel;

  /// MultiSelectDropDown is a widget that allows the user to select multiple options from a list of options. It is a dropdown that allows the user to select multiple options.
  ///
  ///  **Selection Type**
  ///
  ///   [selectionType] is the type of selection that the user can make. The default is [SelectionType.single].
  /// * [SelectionType.single] - allows the user to select only one option.
  /// * [SelectionType.multi] - allows the user to select multiple options.
  ///
  ///  **Options**
  ///
  /// [options] is the list of options that the user can select from. The options need to be of type [ValueItem].
  ///
  /// [selectedOptions] is the list of options that are pre-selected when the widget is first displayed. The options need to be of type [ValueItem].
  ///
  /// [disabledOptions] is the list of options that the user cannot select. The options need to be of type [ValueItem]. If the items in this list are not available in options, will be ignored.
  ///
  /// [onOptionSelected] is the callback that is called when an option is selected or unselected. The callback takes one argument of type `List<ValueItem>`.
  ///
  /// **Selected Option**
  ///
  /// [selectedOptionIcon] is the icon that is used to indicate the selected option.
  ///
  /// [selectedOptionTextColor] is the color of the selected option.
  ///
  /// [selectedOptionBackgroundColor] is the background color of the selected option.
  ///
  /// [selectedItemBuilder] is the builder that is used to build the selected option. If this is not provided, the default builder is used.
  ///
  /// **Chip Configuration**
  ///
  /// [showChipInSingleSelectMode] is used to show the chip in single select mode. The default is false.
  ///
  /// [chipConfig] is the configuration for the chip.
  ///
  /// **Options Configuration**
  ///
  /// [optionsBackgroundColor] is the background color of the options. The default is [Colors.white].
  ///
  /// [optionTextStyle] is the text style of the options.
  ///
  /// [optionSeperator] is the seperator between the options.
  ///
  /// [dropdownHeight] is the height of the dropdown options. The default is 200.
  ///
  ///  **Dropdown Configuration**
  ///
  /// [backgroundColor] is the background color of the dropdown. The default is [Colors.white].
  ///
  /// [suffixIcon] is the icon that is used to indicate the dropdown. The default is [Icons.arrow_drop_down].
  ///
  /// [inputDecoration] is the decoration of the dropdown.
  ///
  /// [dropdownHeight] is the height of the dropdown. The default is 200.
  ///
  ///  **Hint**
  ///
  /// [hint] is the hint text to be displayed when no option is selected.
  ///
  /// [hintColor] is the color of the hint text. The default is [Colors.grey.shade300].
  ///
  /// [hintFontSize] is the font size of the hint text. The default is 14.0.
  ///
  /// [hintStyle] is the style of the hint text.
  ///
  ///  **Example**
  ///
  /// ```dart
  ///  final List<ValueItem> options = [
  ///     ValueItem(label: 'Option 1', value: '1'),
  ///     ValueItem(label: 'Option 2', value: '2'),
  ///     ValueItem(label: 'Option 3', value: '3'),
  ///   ];
  ///
  ///   final List<ValueItem> selectedOptions = [
  ///     ValueItem(label: 'Option 1', value: '1'),
  ///   ];
  ///
  ///   final List<ValueItem> disabledOptions = [
  ///     ValueItem(label: 'Option 2', value: '2'),
  ///   ];
  ///
  ///  MultiSelectDropDown(
  ///    onOptionSelected: (option) {},
  ///    options: const <ValueItem>[
  ///       ValueItem(label: 'Option 1', value: '1'),
  ///       ValueItem(label: 'Option 2', value: '2'),
  ///       ValueItem(label: 'Option 3', value: '3'),
  ///       ValueItem(label: 'Option 4', value: '4'),
  ///       ValueItem(label: 'Option 5', value: '5'),
  ///       ValueItem(label: 'Option 6', value: '6'),
  ///    ],
  ///    selectionType: SelectionType.multi,
  ///    selectedOptions: selectedOptions,
  ///    disabledOptions: disabledOptions,
  ///    onOptionSelected: (List<ValueItem> selectedOptions) {
  ///      debugPrint('onOptionSelected: $option');
  ///    },
  ///    chipConfig: const ChipConfig(wrapType: WrapType.scroll),
  ///    );
  /// ```

  const MultiSelectDropDown(
      {super.key,
      required this.onOptionSelected,
      required this.options,
      this.selectedOptionTextColor,
      this.errorBorderColor = Colors.redAccent,
      this.chipConfig = const ChipConfig(),
      this.selectionType = SelectionType.multi,
      this.hint = 'Select',
      this.hintColor = Colors.grey,
      this.hintFontSize = 14.0,
      this.selectedOptions = const [],
      this.disabledOptions = const [],
      this.alwaysShowOptionIcon = false,
      this.optionTextStyle,
      this.selectedOptionIcon = const Icon(Icons.check),
      this.selectedOptionBackgroundColor,
      this.optionsBackgroundColor,
      this.backgroundColor = Colors.white,
      this.dropdownHeight = 200,
      this.showChipInSingleSelectMode = false,
      this.suffixIcon = const Icon(Icons.arrow_drop_down),
      this.clearIcon = const Icon(Icons.close_outlined, size: 14),
      this.selectedItemBuilder,
      this.optionSeparator,
      this.inputDecoration,
      this.hintStyle,
      this.padding,
      this.focusedBorderColor = Colors.black54,
      this.borderColor = Colors.grey,
      this.borderWidth = 1,
      this.focusedBorderWidth = 1,
      this.borderRadius = 12.0,
      this.radiusGeometry,
      this.showClearIcon = true,
      this.maxItems,
      this.focusNode,
      this.controller,
      this.searchEnabled = false,
      this.isShowOutSideTap = false,
      this.isEnable = true,
      required this.isErroShow,
      this.dropdownBorderRadius,
      this.searchBackgroundColor,
      this.searchLabel = 'Search',
      this.dropdownMargin})
      :
        // networkConfig = null,
        responseParser = null,
        responseErrorBuilder = null;

  @override
  State<MultiSelectDropDown<T>> createState() => _MultiSelectDropDownState<T>();
}

class _MultiSelectDropDownState<T> extends State<MultiSelectDropDown<T>> {
  /// Options list that is used to display the options.
  final List<ValueItem<T>> _options = [];
  List<ValueItem<T>> options = [];

  /// Selected options list that is used to display the selected options.
  final List<ValueItem<T>> _selectedOptions = [];
  List<ValueItem<T>> selectedOptions = [];
  TextEditingController searchController = TextEditingController();

  /// Disabled options list that is used to display the disabled options.
  final List<ValueItem<T>> _disabledOptions = [];

  /// The controller for the dropdown.
  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;
  bool _selectionMode = false;

  late final FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();

  /// Response from the network call.
  dynamic reponseBody;

  /// value notifier that is used for controller.
  MultiSelectController<T>? _controller;

  /// search field focus node
  FocusNode? _searchFocusNode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? MultiSelectController<T>();
  }

  /// Initializes the options, selected options and disabled options.
  /// If the options are fetched from the network, then the network call is made.
  /// If the options are passed as a parameter, then the options are initialized.
  void _initialize() async {
    if (!mounted) return;
    // if (widget.networkConfig?.url != null) {
    //   await _fetchNetwork();
    // } else {
    _options.addAll(_controller?.options.isNotEmpty == true
        ? _controller!.options
        : widget.options);
    selectedOptions = (_selectedOptions);
    // }
    _addOptions();
    _overlayState ??= Overlay.of(context);
    _focusNode.addListener(_handleFocusChange);

    if (widget.searchEnabled) {
      _searchFocusNode = FocusNode();
      // _searchFocusNode!.addListener(_handleFocusChange);
    }
  }

  /// Adds the selected options and disabled options to the options list.
  void _addOptions() {
    setState(() {
      _selectedOptions.addAll(_controller?.selectedOptions.isNotEmpty == true
          ? _controller!.selectedOptions
          : widget.selectedOptions);
      _disabledOptions.addAll(_controller?.disabledOptions.isNotEmpty == true
          ? _controller!.disabledOptions
          : widget.disabledOptions);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller != null && _controller?._isDisposed == false) {
        _controller!.setOptions(_options);
        _controller!.setSelectedOptions(_selectedOptions);
        _controller!.setDisabledOptions(_disabledOptions);

        _controller!.addListener(_handleControllerChange);
      }
    });
  }

  bool isFocusNode = false;

  /// Handles the focus change to show/hide the dropdown.
  _handleFocusChange() {
    // if ((_focusNode.hasFocus && _searchFocusNode!.hasFocus)) {

    // }
    if (((_focusNode.hasFocus) && mounted) && !isFocusNode) {
      _overlayEntry =
          // _reponseBody != null && widget.networkConfig != null
          //     ? _buildNetworkErrorOverlayEntry()
          // :
          _buildOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      isFocusNode = true;
      return;
    }

    if (isFocusNode &&
        (_searchFocusNode == null || _searchFocusNode?.hasFocus == false) &&
        _overlayEntry != null) {
      FocusManager.instance.primaryFocus?.unfocus();
      // FocusManager.instance.primaryFocus?.unfocus();
      // searchController.removeListener(
      //   () {
      searchController.clear();
      // },
      // );
      try {
        _overlayEntry?.remove();
        isFocusNode = false;
      } on Exception catch (e) {}
      // if (isFocusNode) {
      // _overlayEntry?.remove();
      // }
      // if (_overlayEntry!.maintainState) {
      // _overlayEntry?.remove();
      // }
    }

    if (mounted) {
      setState(() {
        _selectionMode =
            _focusNode.hasFocus || _searchFocusNode?.hasFocus == true;
      });
    }

    // if (_controller != null) {
    //   _controller!.value._isDropdownOpen =
    //       _focusNode.hasFocus || _searchFocusNode?.hasFocus == true;
    // }
  }

  /// Handles the widget rebuild when the options are changed externally.
  @override
  void didUpdateWidget(covariant MultiSelectDropDown<T> oldWidget) {
    if (widget.controller == null && oldWidget.controller != null) {
      _controller = MultiSelectController<T>();
    } else if (widget.controller != null && oldWidget.controller == null) {
      _controller!.dispose();
      _controller = null;
    }

    // If the options are changed externally, then the options are updated.
    if (listEquals(widget.options, oldWidget.options) == false) {
      _options.clear();
      _options.addAll(widget.options);

      // If the controller is not null, then the options are updated in the controller.
      if (_controller != null) {
        _controller!.setOptions(_options);
      }
    }

    // If the selected options are changed externally, then the selected options are updated.
    if (listEquals(widget.selectedOptions, oldWidget.selectedOptions) ==
        false) {
      _selectedOptions.clear();
      _selectedOptions.addAll(widget.options
          .where((element) => widget.selectedOptions.contains(element.value)));

      // If the controller is not null, then the selected options are updated in the controller.
      if (_controller != null) {
        _controller!.setSelectedOptions(_selectedOptions);
      }
    }

    // If the disabled options are changed externally, then the disabled options are updated.
    if (listEquals(widget.disabledOptions, oldWidget.disabledOptions) ==
        false) {
      _disabledOptions.clear();
      _disabledOptions.addAll(widget.options
          .where((element) => widget.disabledOptions.contains(element.value)));

      // If the controller is not null, then the disabled options are updated in the controller.
      if (_controller != null) {
        _controller!.setDisabledOptions(_disabledOptions);
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  /// Calculate offset size for dropdown.
  List _calculateOffsetSize() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;

    var size = renderBox?.size ?? Size.zero;
    var offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;

    final availableHeight = MediaQuery.of(context).size.height - offset.dy;

    return [size, availableHeight < widget.dropdownHeight];
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isEnable,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Focus(
          // canRequestFocus: true,
          skipTraversal: false,
          focusNode: _focusNode,
          onFocusChange: (value) {},
          child: InkWell(
            splashColor: null,
            splashFactory: null,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            onTap: _toggleFocus,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height:
                        widget.chipConfig.wrapType == WrapType.wrap ? null : 47,
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      minHeight: 49,
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    decoration: _getContainerDecoration(),
                    child: Row(
                      children: [
                        Expanded(
                          child: _getContainerContent(),
                        ),
                        // Spacer(),
                        if (widget.showClearIcon &&
                            _anyItemSelected &&
                            widget.isEnable &&
                            _selectedOptions.isNotEmpty) ...[
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () {
                              _onOutSideTap();
                              // _toggleFocus();
                              // FocusManager.instance.primaryFocus!.unfocus();
                              clear();
                            },
                            child: const Icon(
                              Icons.close_outlined,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 4)
                        ],
                        if (!_selectionMode)
                          AnimatedRotation(
                            turns: _selectionMode ? 0.5 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: widget.suffixIcon,
                          ),
                      ],
                    ),
                  ),
                  if (widget.isErroShow.value)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: AppText(
                        text:
                            "Please select ${widget.hint.replaceAll("Select", '').trim().toLowerCase()}.",
                        fontColor: Colors.redAccent,
                        fontSize: Sizes.px14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Container Content for the dropdown.
  Widget _getContainerContent() {
    // if (_selectedOptions.isEmpty) {
    //   return Padding(
    //     padding: const EdgeInsets.only(left: 10, right: 10),
    //     child: CommonText(
    //       text: widget.hint,
    //       fontColor: ConstColor.hintTextColor.withOpacity(0.4),
    //       fontSize: Sizes.px14,
    //       fontWeight: FontWeight.w400,
    //       fontFamily: FontConst.museoSans,
    //     ),
    //   );
    // }

    if (widget.selectionType == SelectionType.single &&
        !widget.showChipInSingleSelectMode &&
        _selectedOptions.isNotEmpty) {
      return SingleSelectedItem(
          isEnable: widget.isEnable, label: _selectedOptions.first.label);
    }

    return _buildSelectedItems();
  }

  /// return true if any item is selected.
  bool get _anyItemSelected => _selectedOptions.isNotEmpty;

  /// Container decoration for the dropdown.
  Decoration _getContainerDecoration() {
    return widget.inputDecoration ??
        BoxDecoration(
            color: widget.isEnable
                ? widget.backgroundColor ?? Colors.white
                : ConstColor.appBarTitleColor.withOpacity(0.2),
            borderRadius: widget.radiusGeometry ??
                BorderRadius.circular(widget.borderRadius ?? 12.0),
            border: _selectionMode
                ? Border.all(
                    color: widget.focusedBorderColor ?? Colors.grey,
                    width: widget.focusedBorderWidth ?? 0.4,
                  )
                : Border.all(
                    color: (widget.isErroShow.value)
                        ? Colors.redAccent
                        : (widget.borderColor ?? Colors.grey),
                    width: widget.borderWidth ?? 0.4,
                  ));
  }

  /// Dispose the focus node and overlay entry.
  @override
  void dispose() {
    if (_overlayEntry?.mounted == true) {
      if (_overlayState != null &&
          _overlayEntry != null &&
          _overlayEntry!.maintainState) {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _overlayState?.dispose();
      }
    }
    _focusNode.dispose();
    if (_searchFocusNode != null) {
      _searchFocusNode!.dispose();
    }
    _controller?.removeListener(_handleControllerChange);

    if (widget.controller == null || widget.controller?.isDisposed == true) {
      _controller!.dispose();
    }

    super.dispose();
  }

  /// Build the selected items for the dropdown.
  Widget _buildSelectedItems() {
    if (widget.chipConfig.wrapType == WrapType.scroll) {
      return ListView.separated(
        separatorBuilder: (context, index) =>
            _getChipSeparator(widget.chipConfig),
        scrollDirection: Axis.horizontal,
        itemCount: _selectedOptions.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final option = _selectedOptions[index];
          if (widget.selectedItemBuilder != null) {
            return widget.selectedItemBuilder!(context, option);
          }
          return _buildChip(option, widget.chipConfig);
        },
      );
    }
    return Wrap(
        spacing: widget.chipConfig.spacing,
        runSpacing: widget.chipConfig.runSpacing,
        children: ((selectedOptions.isNotEmpty)
                ? mapIndexed(_selectedOptions, (index, item) {
                    if (widget.selectedItemBuilder != null) {
                      return widget.selectedItemBuilder!(
                          context, _selectedOptions[index]);
                    }
                    return _buildChip(
                        _selectedOptions[index], widget.chipConfig);
                  }).toList()
                : <Widget>[]) +
            [
              TextFormField(
                onTapOutside: (event) {
                  // _onOutSideTap();
                },
                scrollPadding: MediaQuery.of(context).viewInsets,
                controller: searchController,
                // autofocus: true,
                focusNode: _searchFocusNode,
                // onChanged: (value) {
                //   dropdowmState(() {
                //     options = _options
                //         .where((element) => element.label
                //             .toLowerCase()
                //             .contains(value.toLowerCase()))
                //         .toList();
                //   });
                // },
                cursorColor: ConstColor.appBarTitleColor,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    hintText: _selectedOptions.isEmpty ? widget.hint : "",
                    hintStyle: TextStyle(
                      color: ConstColor.hintTextColor.withOpacity(0.4),
                      fontSize: Sizes.px14,
                      fontWeight: FontWeight.w400,
                    )),
              )
            ]);
  }

  /// Util method to map with index.
  Iterable<E> mapIndexed<E, F>(
      Iterable<F> items, E Function(int index, F item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }

  /// Get the chip separator.
  Widget _getChipSeparator(ChipConfig chipConfig) {
    if (chipConfig.separator != null) {
      return chipConfig.separator!;
    }

    return SizedBox(
      width: chipConfig.spacing,
    );
  }

  /// Handle the focus change on tap outside of the dropdown.
  void _onOutSideTap() {
    if (_searchFocusNode != null) {
      _searchFocusNode!.unfocus();
      // _overlayEntry?.remove();
    }
    _focusNode.unfocus();
  }

  /// Buid the selected item chip.
  Widget _buildChip(ValueItem<T> item, ChipConfig chipConfig) {
    return Wrap(
      children: [
        SelectionChip<T>(
          item: item,
          chipConfig: chipConfig,
          onItemDelete: (removedItem) {
            if (_controller != null) {
              _controller!.clearSelection(removedItem);
            } else {
              setState(() {
                _selectedOptions.remove(removedItem);
              });
              widget.onOptionSelected?.call(_selectedOptions);
            }
            if (_focusNode.hasFocus) _focusNode.unfocus();
          },
        ),
        // if (_selectedOptions.last == item)
        //   TextFormField(
        //     onTapOutside: (event) {},
        //     controller: searchController,
        //     // onChanged: (value) {
        //     //   dropdowmState(() {
        //     //     options = _options
        //     //         .where((element) => element.label
        //     //             .toLowerCase()
        //     //             .contains(value.toLowerCase()))
        //     //         .toList();
        //     //   });
        //     // },
        //     decoration: const InputDecoration(
        //       border: InputBorder.none,
        //     ),
        //   )
      ],
    );
  }

  /// Method to toggle the focus of the dropdown.
  void _toggleFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  /// Get the selectedItem icon for the dropdown
  Widget? _getSelectedIcon(bool isSelected, Color primaryColor) {
    if (isSelected) {
      return widget.selectedOptionIcon ??
          Icon(
            Icons.check,
            color: primaryColor,
          );
    }
    if (!widget.alwaysShowOptionIcon) {
      return null;
    }

    final Icon icon = widget.selectedOptionIcon ??
        Icon(
          Icons.check,
          color: widget.optionTextStyle?.color ?? Colors.grey,
        );

    return icon;
  }

  /// Create the overlay entry for the dropdown.
  OverlayEntry _buildOverlayEntry() {
    // Calculate the offset and the size of the dropdown button
    final values = _calculateOffsetSize();
    // Get the size from the first item in the values list
    final size = values[0] as Size;
    // Get the showOnTop value from the second item in the values list
    final showOnTop = values[1] as bool;

    return OverlayEntry(
        // maintainState: true,
        builder: (context) {
      options = _options;
      selectedOptions = [..._selectedOptions];

      // searchController = TextEditingController();

      return StatefulBuilder(builder: ((context, dropdownState) {
        searchController.addListener(() {
          if (context.mounted) {
            dropdownState(() {
              options = _options
                  .where((element) => element.label
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()))
                  .toList();
            });
          }
        });
        return Stack(
          children: [
            if (widget.isShowOutSideTap)
              GestureDetector(
                // behavior: HitTestBehavior.translucent,
                onTap: _onOutSideTap,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: true,
              targetAnchor:
                  showOnTop ? Alignment.topLeft : Alignment.bottomLeft,
              followerAnchor:
                  showOnTop ? Alignment.bottomLeft : Alignment.topLeft,
              offset: widget.dropdownMargin != null
                  ? Offset(
                      0,
                      showOnTop
                          ? -widget.dropdownMargin!
                          : widget.dropdownMargin!)
                  : Offset.zero,
              child: Material(
                  borderRadius: widget.dropdownBorderRadius != null
                      ? BorderRadius.circular(widget.dropdownBorderRadius!)
                      : null,
                  elevation: 4,
                  color: ConstColor.whiteColor,
                  shadowColor: Colors.black,
                  child: Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    constraints: BoxConstraints.loose(
                        Size(size.width, widget.dropdownHeight)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // if (widget.searchEnabled) ...[
                        //   Padding(
                        //     padding: const EdgeInsets.all(10),
                        //     child: TextFormField(
                        //       controller: searchController,
                        //       onTapOutside: (_) {
                        //         _onOutSideTap;
                        //         // if (_focusNode.hasFocus) {
                        //         // _focusNode.unfocus();
                        //         // if (_overlayEntry!.maintainState) {
                        //         //   _overlayEntry?.remove();
                        //         // }
                        //         // // _focusNode.unfocus();
                        //         // _searchFocusNode?.unfocus();
                        //         // }
                        //         // FocusManager.instance.primaryFocus!.unfocus();
                        //         // FocusScope.of(context).unfocus();
                        //       },
                        //       // scrollPadding: EdgeInsets.only(
                        //       //     bottom:
                        //       //         MediaQuery.of(context).viewInsets.bottom),
                        //       style: TextStyle(
                        //           fontFamily: FontConst.museoSans,
                        //           color: ConstColor.buttonColor,
                        //           fontSize: Sizes.px14,
                        //           fontWeight: FontWeight.w400),

                        //       focusNode: _searchFocusNode,
                        //       cursorColor: ConstColor.mainColor,
                        //       decoration: InputDecoration(
                        //         contentPadding:
                        //             EdgeInsets.symmetric(horizontal: 20.w),
                        //         fillColor: widget.searchBackgroundColor ??
                        //             Colors.grey.shade200,
                        //         isDense: true,
                        //         filled: widget.searchBackgroundColor != null,
                        //         hintStyle: TextStyle(
                        //           color:
                        //               ConstColor.hintTextColor.withOpacity(0.4),
                        //           fontSize: Sizes.px14,
                        //           fontWeight: FontWeight.w400,
                        //           fontFamily: FontConst.museoSans,
                        //         ),
                        //         hintText: widget.searchLabel,
                        //         enabledBorder: OutlineInputBorder(
                        //           borderSide: Get.size.shortestSide < 600
                        //               ? BorderSide(
                        //                   color: ConstColor.borderColor,
                        //                   width: 1.h)
                        //               : BorderSide(
                        //                   color: ConstColor.borderColor,
                        //                   width: 1.h),
                        //           borderRadius: BorderRadius.all(
                        //             Get.size.shortestSide < 600
                        //                 ? Radius.circular(30.r)
                        //                 : Radius.circular(40.r),
                        //           ),
                        //         ),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderSide: Get.size.shortestSide < 600
                        //               ? BorderSide(
                        //                   color: ConstColor.borderColor,
                        //                   width: 1.h)
                        //               : BorderSide(
                        //                   color: ConstColor.borderColor,
                        //                   width: 1.h),
                        //           borderRadius: BorderRadius.all(
                        //             Get.size.shortestSide < 600
                        //                 ? Radius.circular(30.r)
                        //                 : Radius.circular(40.r),
                        //           ),
                        //         ),
                        //         suffixIcon: IconButton(
                        //           icon: Icon(
                        //             searchController.text.trim().isNotEmpty
                        //                 ? Icons.close_outlined
                        //                 : null,
                        //             size: 20,
                        //           ),
                        //           onPressed:
                        //               searchController.text.trim().isNotEmpty
                        //                   ? () {
                        //                       searchController.clear();
                        //                       dropdownState(() {
                        //                         options = _options;
                        //                       });
                        //                     }
                        //                   : null,
                        //         ),
                        //       ),
                        //       onChanged: (value) {
                        //         dropdownState(() {
                        //           options = _options
                        //               .where((element) => element.label
                        //                   .toLowerCase()
                        //                   .contains(value.toLowerCase()))
                        //               .toList();
                        //         });
                        //       },
                        //     ),
                        //   ),
                        //   const Divider(
                        //     height: 1,
                        //   ),
                        // ],

                        Flexible(
                          child: options.isEmpty
                              ? Container(
                                  height: 50,
                                  width: size.width,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(top: 5.0),
                                  // constraints: BoxConstraints.loose(
                                  //     Size(size.width, 50)),
                                  child: AppText(text: "No result found"),
                                )
                              : ListView.separated(
                                  separatorBuilder: (_, __) =>
                                      widget.optionSeparator ??
                                      const SizedBox(height: 0),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    final option = options[index];
                                    final isSelected =
                                        selectedOptions.contains(option);
                                    final primaryColor =
                                        Theme.of(context).primaryColor;
                                    return _buildOption(
                                        option,
                                        primaryColor,
                                        isSelected,
                                        dropdownState,
                                        selectedOptions);
                                  },
                                ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        );
      }));
    });
  }

  Widget _buildOption(ValueItem<T> option, Color primaryColor, bool isSelected,
      StateSetter dropdownState, List<ValueItem<T>> selectedOptions) {
    return ListTile(
        title: Text(option.label, style: widget.optionTextStyle),
        textColor: Colors.black,
        titleTextStyle: TextStyle(
            fontSize: widget.hintFontSize ?? Sizes.px14,
            color: ConstColor.blackColor,
            // fontSize: Sizes.px14,
            fontWeight: FontWeight.w300),
        focusColor: Colors.redAccent,
        selectedColor: widget.selectedOptionTextColor ?? primaryColor,
        selected: isSelected,
        autofocus: true,
        dense: true,
        tileColor: widget.optionsBackgroundColor ?? Colors.transparent,
        selectedTileColor:
            widget.selectedOptionBackgroundColor ?? Colors.transparent,
        // enabled: !_disabledOptions.contains(option),
        onTap: () {
          searchController.clear();
          if (widget.selectionType == SelectionType.multi) {
            if (isSelected) {
              dropdownState(() {
                selectedOptions.remove(option);
              });
              setState(() {
                _selectedOptions.remove(option);
              });
            } else {
              final bool hasReachMax = widget.maxItems == null
                  ? false
                  : (_selectedOptions.length + 1) > widget.maxItems!;
              if (hasReachMax) return;

              dropdownState(() {
                selectedOptions.add(option);
              });
              setState(() {
                _selectedOptions.add(option);
              });
            }
          } else {
            dropdownState(() {
              selectedOptions.clear();
              if (!selectedOptions.contains(option)) {
                selectedOptions.add(option);
              }
            });
            setState(() {
              _selectedOptions.clear();
              if (!_selectedOptions.contains(option)) {
                _selectedOptions.add(option);
              }
            });
            _focusNode.unfocus();
          }

          if (_controller != null) {
            _controller!.value._selectedOptions.clear();
            _controller!.value._selectedOptions.addAll(_selectedOptions);
          }

          widget.onOptionSelected?.call(_selectedOptions);
        },
        trailing: _getSelectedIcon(isSelected, primaryColor));
  }

  /// Clear the selected options.
  /// [MultiSelectController] is used to clear the selected options.
  void clear() {
    // if (_controller != null && !_controller!._isDisposed) {
    if (_controller != null && !_controller!._isDisposed) {
      _controller!.clearAllSelection();
      setState(() {
        _selectedOptions.clear();
      });
      widget.onOptionSelected?.call(_selectedOptions);
    } else {}
    if (_focusNode.hasFocus) _focusNode.unfocus();
  }

  /// handle the controller change.
  void _handleControllerChange() {
    // if the controller is null, return.
    if (_controller == null || _controller?.isDisposed == true) return;

    // if current disabled options are not equal to the controller's disabled options, update the state.
    if (_disabledOptions != _controller!.value._disabledOptions) {
      setState(() {
        _disabledOptions.clear();
        _disabledOptions.addAll(_controller!.value._disabledOptions);
      });
    }

    // if current options are not equal to the controller's options, update the state.
    if (_options != _controller!.value._options) {
      setState(() {
        _options.clear();
        _options.addAll(_controller!.value._options);
      });
    }

    // if current selected options are not equal to the controller's selected options, update the state.
    if (_selectedOptions != _controller!.value._selectedOptions) {
      setState(() {
        _selectedOptions.clear();
        _selectedOptions.addAll(_controller!.value._selectedOptions);
      });
      widget.onOptionSelected?.call(_selectedOptions);
    }

    if (_selectionMode != _controller!.value._isDropdownOpen) {
      if (_controller!.value._isDropdownOpen) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    }
  }

  // get the container padding.
  // EdgeInsetsGeometry _getContainerPadding() {
  //   if (widget.padding != null) {
  //     return widget.padding!;
  //   }
  //   return widget.selectionType == SelectionType.single
  //       ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0)
  //       : const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0);
  // }
}

/// MultiSelect Controller class.
/// This class is used to control the state of the MultiSelectDropdown widget.
/// This is just base class. The implementation of this class is in the MultiSelectController class.
/// The implementation of this class is hidden from the user.
class _MultiSelectController<T> {
  final List<ValueItem<T>> _disabledOptions = [];
  final List<ValueItem<T>> _options = [];
  final List<ValueItem<T>> _selectedOptions = [];
  bool _isDropdownOpen = false;
}

/// implementation of the MultiSelectController class.
class MultiSelectController<T>
    extends ValueNotifier<_MultiSelectController<T>> {
  MultiSelectController() : super(_MultiSelectController());

  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  /// set the dispose method.
  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  /// Clear the selected options.
  /// [MultiSelectController] is used to clear the selected options.
  void clearAllSelection() {
    value._selectedOptions.clear();
    notifyListeners();
  }

  /// clear specific selected option
  /// [MultiSelectController] is used to clear specific selected option.
  void clearSelection(ValueItem<T> option) {
    if (!value._selectedOptions.contains(option)) return;

    if (value._disabledOptions.contains(option)) {
      throw Exception('Cannot clear selection of a disabled option');
    }

    if (!value._options.contains(option)) {
      throw Exception(
          'Cannot clear selection of an option that is not in the options list');
    }

    value._selectedOptions.remove(option);
    notifyListeners();
  }

  /// select the options
  /// [MultiSelectController] is used to select the options.
  void setSelectedOptions(List<ValueItem<T>> options) {
    if (options.any((element) => value._disabledOptions.contains(element))) {
      throw Exception('Cannot select disabled options');
    }

    if (options.any((element) => !value._options.contains(element))) {
      throw Exception('Cannot select options that are not in the options list');
    }

    value._selectedOptions.clear();
    value._selectedOptions.addAll(options);
    notifyListeners();
  }

  /// add selected option
  /// [MultiSelectController] is used to add selected option.
  void addSelectedOption(ValueItem<T> option) {
    if (value._disabledOptions.contains(option)) {
      throw Exception('Cannot select disabled option');
    }

    if (!value._options.contains(option)) {
      throw Exception('Cannot select option that is not in the options list');
    }

    value._selectedOptions.add(option);
    notifyListeners();
  }

  /// set disabled options
  /// [MultiSelectController] is used to set disabled options.
  void setDisabledOptions(List<ValueItem<T>> disabledOptions) {
    if (disabledOptions.any((element) => !value._options.contains(element))) {
      throw Exception(
          'Cannot disable options that are not in the options list');
    }

    value._disabledOptions.clear();
    value._disabledOptions.addAll(disabledOptions);
    notifyListeners();
  }

  /// setDisabledOption method
  /// [MultiSelectController] is used to set disabled option.
  void setDisabledOption(ValueItem<T> disabledOption) {
    if (!value._options.contains(disabledOption)) {
      throw Exception('Cannot disable option that is not in the options list');
    }

    value._disabledOptions.add(disabledOption);
    notifyListeners();
  }

  /// set options
  /// [MultiSelectController] is used to set options.
  void setOptions(List<ValueItem<T>> options) {
    value._options.clear();
    value._options.addAll(options);
    notifyListeners();
  }

  /// get disabled options
  List<ValueItem<T>> get disabledOptions => value._disabledOptions;

  /// get enabled options
  List<ValueItem<T>> get enabledOptions => value._options
      .where((element) => !value._disabledOptions.contains(element))
      .toList();

  /// get options
  List<ValueItem<T>> get options => value._options;

  /// get selected options
  List<ValueItem<T>> get selectedOptions => value._selectedOptions;

  /// get is dropdown open
  bool get isDropdownOpen => value._isDropdownOpen;

  /// show dropdown
  /// [MultiSelectController] is used to show dropdown.
  void showDropdown() {
    if (value._isDropdownOpen) return;
    value._isDropdownOpen = true;
    notifyListeners();
  }

  /// hide dropdown
  /// [MultiSelectController] is used to hide dropdown.
  void hideDropdown() {
    if (!value._isDropdownOpen) return;
    value._isDropdownOpen = false;
    notifyListeners();
  }
}

/// [label] is the item that is displayed in the list. [value] is the value that is returned when the item is selected.
/// If the [value] is not provided, the [label] is used as the value.
/// An example of a [ValueItem] is:
/// ```dart
/// const ValueItem(label: 'Option 1', value: '1')
/// ```

class ValueItem<T> {
  /// The label of the value item
  final String label;

  /// The value of the value item
  final T? value;

  /// Default constructor for [ValueItem]
  const ValueItem({required this.label, required this.value});

  /// toString method for [ValueItem]
  @override
  String toString() {
    return 'ValueItem(label: $label, value: $value)';
  }

  /// toMap method for [ValueItem]
  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'value': value,
    };
  }

  /// fromMap method for [ValueItem]
  factory ValueItem.fromMap(Map<String, dynamic> map) {
    return ValueItem<T>(
      label: map['label'] ?? '',
      value: map['value'],
    );
  }

  /// toJson method for [ValueItem]
  String toJson() => json.encode(toMap());

  /// fromJson method for [ValueItem]
  factory ValueItem.fromJson(String source) =>
      ValueItem<T>.fromMap(json.decode(source));

  /// Equality operator for [ValueItem]
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueItem<T> &&
        other.label == label &&
        other.value == value;
  }

  /// Hashcode for [ValueItem]
  @override
  int get hashCode => label.hashCode ^ value.hashCode;

  /// CopyWith method for [ValueItem]
  ValueItem<T> copyWith({
    String? label,
    T? value,
  }) {
    return ValueItem<T>(
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }
}

/// [SelectionType]
/// SelectionType enum for the selection type of the dropdown items.
/// * [single]: single selection
/// * [multi]: multi selection
enum SelectionType {
  single,
  multi,
}

/// [WrapType]
/// WrapType enum for the wrap type of the selected items.
/// * [WrapType.scroll]: scroll the selected items horizontally
/// * [WrapType.wrap]: wrap the selected items in both directions
enum WrapType { scroll, wrap }

/// [RequestMethod]
/// RequestMethod enum for the request method of the dropdown items.
/// * [RequestMethod.get]: get request
/// * [RequestMethod.post]: post request
/// * [RequestMethod.put]: put request
/// * [RequestMethod.delete]: delete request
/// * [RequestMethod.patch]: patch request
enum RequestMethod { get, post, put, patch, delete }

class ChipConfig {
  final Icon? deleteIcon;

  final Color deleteIconColor;
  final Color labelColor;
  final Color? backgroundColor;

  final TextStyle? labelStyle;
  final EdgeInsets padding;
  final EdgeInsets labelPadding;

  final double radius;
  final double spacing;
  final double runSpacing;

  final Widget? separator;

  final WrapType wrapType;

  final bool autoScroll;

  const ChipConfig({
    this.deleteIcon,
    this.deleteIconColor = Colors.white,
    this.backgroundColor,
    this.padding = const EdgeInsets.only(left: 12, top: 0, right: 4, bottom: 0),
    this.radius = 18,
    this.spacing = 8,
    this.runSpacing = -8,
    this.separator,
    this.labelColor = Colors.white,
    this.labelStyle,
    this.wrapType = WrapType.scroll,
    this.labelPadding = EdgeInsets.zero,
    this.autoScroll = false,
  });
}

/// [SelectionChip] is a selected option chip builder.
/// It is used to build the selected option chip.
class SelectionChip<T> extends StatelessWidget {
  final ChipConfig chipConfig;
  final Function(ValueItem<T>) onItemDelete;
  final ValueItem<T> item;

  const SelectionChip({
    super.key,
    required this.chipConfig,
    required this.item,
    required this.onItemDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: chipConfig.padding,
      color: const WidgetStatePropertyAll(ConstColor.whiteColor),
      label: AppText(
        text: item.label,
        fontColor: ConstColor.blackColor,
        fontSize: Sizes.px14,
        fontWeight: FontWeight.w300,
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: ConstColor.appBarTitleColor),
        borderRadius: BorderRadius.circular(chipConfig.radius),
      ),
      deleteIcon: chipConfig.deleteIcon,
      deleteIconColor: ConstColor.buttonColor,
      labelPadding: chipConfig.labelPadding,
      backgroundColor:
          chipConfig.backgroundColor ?? Theme.of(context).primaryColor,
      labelStyle: chipConfig.labelStyle ??
          TextStyle(color: chipConfig.labelColor, fontSize: 14),
      onDeleted: () => onItemDelete(item),
    );
  }
}

class HintText extends StatelessWidget {
  final TextStyle? hintStyle;
  final String hintText;
  final Color? hintColor;

  const HintText({
    super.key,
    this.hintStyle,
    required this.hintText,
    this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        hintText,
        style: hintStyle ??
            TextStyle(
              fontSize: 13,
              color: hintColor ?? Colors.grey.shade300,
            ),
      ),
    );
  }
}

class SingleSelectedItem extends StatelessWidget {
  final String label;
  final bool isEnable;
  const SingleSelectedItem(
      {super.key, required this.label, required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        label,
        style: TextStyle(
          // fontSize: 13,
          // color: Colors.grey.shade700,
          color: isEnable
              ? const Color(0xff313c66)
              : const Color(0xff313c66).withOpacity(0.4),
          fontSize: Sizes.px14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

Widget commonSelectorPlaceHolder(BuildContext context, String hint) {
  return Container(
    height: 47,
    constraints: BoxConstraints(
      minWidth: MediaQuery.of(context).size.width,
      minHeight: 49,
    ),
    padding: const EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: ConstColor.borderColor,
        width: 1,
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: AppText(
            text: hint,
            fontColor: ConstColor.hintTextColor,
            fontSize: Sizes.px14,
            fontWeight: FontWeight.w400,
            amalfiFontFamily: CommonFontStyle.plusJakartaSans,
          ),
        ),
        // Spacer(),
        Transform.rotate(
          angle: pi / 2,
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: ConstColor.hintTextColor,
          ),
        ),
      ],
    ),
  );
}
