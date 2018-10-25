import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: "News",
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  //doing api fetches here (bloc.dosomething)
  //We dont want to do it inside the build method of that widget.
  //Any better place to do this?
  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        final bloc = StoriesProvider.of(context);
        bloc.fetchTopIds();
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        final itemId = int.parse(settings.name.replaceFirst('/', ''));
        final commentsBloc = CommentsProvider.of(context);
        commentsBloc.fetchItemWithComments(itemId);
        return NewsDetail(itemId: itemId);
      });
    }
  }
}
