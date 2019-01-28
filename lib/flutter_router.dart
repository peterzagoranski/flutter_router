library flutter_router;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uri/uri.dart';

typedef Widget RouterBuilder(BuildContext context, UriMatch match);

class Router extends _Router {
  Router(final Map<String, RouterBuilder> definitions) : super(definitions, page: <Null>(settings, builder) => new MaterialPageRoute<Null>(builder: builder, settings: settings));
}

class CupertinoRouter extends _Router {
  CupertinoRouter(final Map<String, RouterBuilder> definitions) : super(definitions, page: <Null>(settings, builder) => new CupertinoPageRoute<Null>(settings: settings, builder: builder));
}

abstract class _Router {

  _Router(final Map<String, RouterBuilder> definitions, { this.page }) : assert(null != definitions), assert(null != page), this.definitions = definitions;

  Route<dynamic> get(final RouteSettings settings) {
    final matches = this.definitions.keys.where((route) => UriParser(UriTemplate(route)).matches(Uri.parse(settings.name)));
    final route = null != matches && matches.length > 0 ? matches.first : null;

    return null != route ? this.page(settings, (context)=> this.definitions[route](context, UriParser(UriTemplate(route)).match(Uri.parse(settings.name)))) : null;
  }

  final Map<String, RouterBuilder> definitions;
  final PageRouteFactory page;
}