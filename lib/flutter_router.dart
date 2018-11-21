library flutter_router;

import 'package:flutter/material.dart';
import 'package:uri/uri.dart';

typedef Widget RouterBuilder(BuildContext context, UriMatch match);

class Router {

  const Router(final Map<String, RouterBuilder> definitions) : assert(definitions != null), this.definitions = definitions;

  Route<dynamic> get(final RouteSettings settings) {
    final route = this.definitions.keys.where((route) => UriParser(UriTemplate(route)).matches(Uri.parse(settings.name))).first;
    
    return MaterialPageRoute(builder: (context)=> this.definitions[route](context, UriParser(UriTemplate(route)).match(Uri.parse(settings.name))), settings: settings);
  }

  final Map<String, RouterBuilder> definitions;
}