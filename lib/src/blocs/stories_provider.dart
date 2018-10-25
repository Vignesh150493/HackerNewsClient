import 'package:flutter/material.dart';
import 'stories_bloc.dart';
export 'stories_bloc.dart';

/// A provider always goes with the block.
/// Provider makes block available at any location in widget tree.
/// Provider for StoriesBloc bloc
class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }
}
