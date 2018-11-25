library flutter_router;

import 'package:flutter/material.dart';
import 'package:uri/uri.dart';

typedef Widget RouterBuilder(BuildContext context, UriMatch match);

class Router {

  const Router(final Map<String, RouterBuilder> definitions) : assert(definitions != null), this.definitions = definitions;

  Route<dynamic> get(final RouteSettings settings) {
    final matches = this.definitions.keys.where((route) => UriParser(UriTemplate(route)).matches(Uri.parse(settings.name)));
    final route = null != matches && matches.length > 0 ? matches.first : null;
    
    return null != route ? MaterialPageRoute(builder: (context)=> this.definitions[route](context, UriParser(UriTemplate(route)).match(Uri.parse(settings.name))), settings: settings) : null;
  }

  final Map<String, RouterBuilder> definitions;
}