import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router/flutter_router.dart' as FRouter;

void main() => runApp(MaterialApp(
  onGenerateRoute: FRouter.Router({
    '/accounts/{id}': (context, match) => Account(match!.parameters['id']!),
    '/': (context, match) => Index(),
  }).get,
));

/*void main() => runApp(CupertinoApp(
  onGenerateRoute: CupertinoRouter({
    '/accounts/{id}': (context, match) => Account(match.parameters['id']),
    '/': (context, match) => Index(),
  }).get,
));*/

class Account extends StatelessWidget {
  final String id;

  Account(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(this.id)));
  }
}

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Index')));
  }
}
