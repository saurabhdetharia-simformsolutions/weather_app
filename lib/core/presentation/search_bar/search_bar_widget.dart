import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/core/presentation/weather/weather_bloc/weather_bloc.dart';

import '../../app_strings.dart';
import '../../data/models/search_location/search_location_res.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.onTapItem,
    this.debounceTime = 600,
  });

  final void Function(Result) onTapItem;

  final int debounceTime;

  @override
  SearchBarWidgetState createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  TextStyle darkColorText = const TextStyle(color: Color(0xffb6d3fe));
  TextStyle lowerDarkText = const TextStyle(color: Colors.black38);
  TextStyle lightColorText = const TextStyle(color: Color(0xff90d6e1));
  Color searchBarColor = Colors.lightBlue.shade50;
  Color scaffoldColor = const Color(0xff323c45);
  Color containerColor = const Color(0xff8db9fc);

  final subject = PublishSubject<String>();
  OverlayEntry? _overlayEntry;
  List<String> alPredictions = [];

  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  bool isSearched = false;
  FocusNode focusNode = FocusNode();

  List<Result> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is SearchLocationState) {
          searchResults = state.searchLocationRes.results;
          final list = searchResults.map((e) => e.name);
          alPredictions
            ..clear()
            ..addAll((list));

          _overlayEntry = null;
          _overlayEntry = _createOverlayEntry();
          if (mounted) {
            Overlay.of(context).insert(_overlayEntry!);
          }
        }
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: SearchBar(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 15)),
          elevation: MaterialStateProperty.all(0),
          controller: _searchController,
          focusNode: focusNode,
          textStyle: MaterialStateProperty.all(
            lowerDarkText.copyWith(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          leading: Icon(
            Icons.search,
            color: lowerDarkText.color,
          ),
          backgroundColor: MaterialStateProperty.all(searchBarColor),
          hintText: searchYourLocation,
          hintStyle: MaterialStateProperty.all(
            lowerDarkText.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
          onChanged: textChanged,
        ),
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

    context.read<WeatherBloc>().add(SearchLocationEvent(location: text));
    //await homeStore.getCityNames(text);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (focusNode.canRequestFocus) {
        focusNode.requestFocus();
      }
    });
    subject.stream
        .distinct()
        .debounceTime(Duration(milliseconds: widget.debounceTime))
        .listen(textChanged);
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
                          FocusManager.instance.primaryFocus?.unfocus();
                          _searchController.text = alPredictions[index];
                          widget.onTapItem(searchResults[index]);
                          removeOverlay();
                          return;
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        color: searchBarColor,
                        child: Text(
                          alPredictions[index],
                          style: lowerDarkText.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                          ),
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
