import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';
import 'dart:math' as math;

class NewsDetail extends StatelessWidget {

  final int itemId;

  NewsDetail({this.itemId});

  final GlobalKey stickyKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: buildBody(bloc),
    );
  }

  buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading');
        }

        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Loading');
            }

            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    final commentsList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();
    children.addAll(commentsList);
    return CustomScrollView(
      slivers: <Widget>[
        makeHeader(item.title),
        SliverList(
          delegate: SliverChildListDelegate(children),
        ),
      ],
    );
  }

  SliverPersistentHeader makeHeader(String headerText) {
    final keyContext = stickyKey.currentContext;
    RenderBox box;
    if (keyContext != null) {
      // widget is visible
      box = keyContext.findRenderObject();
    }
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: keyContext != null ? box.size.height + 10.0 : 60.0,
        maxHeight: 250.0,
        child: Container(
            color: Colors.lightBlue,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                  child: Text(
                headerText,
                key: stickyKey,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              )),
            )),
      ),
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10.0),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}