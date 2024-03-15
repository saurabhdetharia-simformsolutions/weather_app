library google_places_flutter;

import 'dart:math';

import 'package:flutter/material.dart';

class SearchBarWithSuggestions extends StatefulWidget {
  const SearchBarWithSuggestions({
    super.key,
    required this.itemClick,
    this.debounceTime = 600,
  });

  final void Function(String) itemClick;

  final int debounceTime;

  @override
  SearchBarWithSuggestionsState createState() =>
      SearchBarWithSuggestionsState();
}

class SearchBarWithSuggestionsState extends State<SearchBarWithSuggestions> {
  TextStyle darkColorText = const TextStyle(color: Color(0xffb6d3fe));
  TextStyle lowerDarkText = const TextStyle(color: Colors.black38);
  TextStyle lightColorText = const TextStyle(color: Color(0xff90d6e1));
  Color searchBarColor = Colors.lightBlue.shade50;
  Color scaffoldColor = const Color(0xff323c45);
  Color containerColor = const Color(0xff261F14);

  // final subject = '';
  OverlayEntry? _overlayEntry;
  List<String> alPredictions = [];

  TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  bool isSearched = false;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: SearchAnchor(
         builder:(context, controller) =>  SearchBar(
          elevation: MaterialStateProperty.all(0),
          controller: _searchController,
          textStyle: MaterialStateProperty.all(
            lowerDarkText.copyWith(
              fontSize: 20,
            ),
          ),
          leading: Icon(
            Icons.location_on_outlined,
            color: lowerDarkText.color,
          ),
          backgroundColor: MaterialStateProperty.all(searchBarColor),
          hintText: 'Search your location',
          hintStyle: MaterialStateProperty.all(
            lowerDarkText.copyWith(
              fontSize: 20,
            ),
          ),
          onChanged: textChanged,
        ),
        suggestionsBuilder: (context, controller) =>[SizedBox()],
      ),
    );
  }

  Future<void> getLocation(String text) async {
    if (_overlayEntry != null && _overlayEntry!.mounted) {
      _overlayEntry!.remove();
    }
    if (text.isEmpty) {
      alPredictions.clear();
      return;
    }

    isSearched = false;
    // if (subscriptionResponse.predictions!.isNotEmpty) {
    final data = (['sgsgs', 'dasdas', 'waswww', 'wadwd', 'dwwd', 'wqdd']
      ..shuffle(Random()));
    alPredictions
      ..clear()
      ..addAll(data);
    // }

    _overlayEntry = null;
    _overlayEntry = _createOverlayEntry();
    if (mounted) {
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  @override
  void initState() {
    super.initState();
    // subject.stream
    //     .distinct()
    //     .debounceTime(Duration(milliseconds: widget.debounceTime))
    //     .listen(textChanged);
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        removeOverlay();
      }
    });
  }

  Future<void> textChanged(String text) async {
    await getLocation(text);
  }

  OverlayEntry? _createOverlayEntry() {
    if (context.findRenderObject() != null) {
      final renderBox = context.findRenderObject()! as RenderBox;
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);
      return OverlayEntry(
        builder: (context) => Positioned(
          left: offset.dx,
          top: size.height + offset.dy,
          width: size.width,
          child: CompositedTransformFollower(
            showWhenUnlinked: false,
            link: _layerLink,
            offset: Offset(0, size.height + 5.0),
            child: Material(
              elevation: 1,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: alPredictions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (index < alPredictions.length) {
                          _searchController.text = alPredictions[index];
                          widget.itemClick(alPredictions[index]);
                          removeOverlay();
                          return;
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: searchBarColor,
                        child: Text(
                          alPredictions[index],
                          style: lowerDarkText.copyWith(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    }
    return null;
  }

  void removeOverlay() {
    alPredictions.clear();
    if (_overlayEntry != null && _overlayEntry!.mounted) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}