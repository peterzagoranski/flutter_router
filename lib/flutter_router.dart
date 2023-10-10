library flutter_router;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uri/uri.dart';

typedef Widget RouterBuilder(BuildContext context, UriMatch? match, RouteSettings settings);

class Router extends _Router {
  Router(final Map<String, RouterBuilder> definitions) : super(definitions, page: (<Null>(settings, builder) => new MaterialPageRoute<Null>(builder: builder, settings: settings)));
}

class CupertinoRouter extends _Router {
  CupertinoRouter(final Map<String, RouterBuilder> definitions) : super(definitions, page: (<Null>(settings, builder) => new CupertinoPageRoute<Null>(settings: settings, builder: builder)));
}

abstract class _Router {

  _Router(final Map<String, RouterBuilder> definitions, { required this.page }) : this.definitions = definitions;

  Route<dynamic>? get(final RouteSettings settings) {
    final matches = this.definitions.keys.where((route) => UriParser(UriTemplate(route)).matches(Uri.parse(settings.name!)));
    final route = matches.length > 0 ? matches.first : null;

    return null != route ? this.page(settings, (context)=> this.definitions[route]!(context, UriParser(UriTemplate(route)).match(Uri.parse(settings.name!)), settings)) : null;
  }

  final Map<String, RouterBuilder> definitions;
  final PageRouteFactory page;
}

class Navigators extends _Navigators {
  Navigators(final List<Navigator> navigators) : super(navigators, page: (<Null>(settings, builder) => MaterialPageRoute<Null>(settings: settings, builder: builder)));
}

abstract class _Navigators {
  _Navigators(this.navigators, { this.page }) : assert( null != page);

  Route<dynamic>? get(final RouteSettings settings) {
    final matches = this.navigators.where((navigator) => navigator.initialRoute!.startsWith(settings.name!));

    return matches.length > 0 ? this.page!(settings, (context) => matches.first) : null;
  }
  
  final List<Navigator> navigators;
  final PageRouteFactory? page;
}