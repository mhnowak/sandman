// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(code) => "Invalid status code ${code}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "createProductAppBarTitle":
            MessageLookupByLibrary.simpleMessage("Add product"),
        "createProductDescription":
            MessageLookupByLibrary.simpleMessage("Description"),
        "createProductFloatingButtonTitle":
            MessageLookupByLibrary.simpleMessage("Add"),
        "createProductInvalidRequestErrorMessage":
            MessageLookupByLibrary.simpleMessage(
                "Title, description and image cannot be empty"),
        "createProductTitle": MessageLookupByLibrary.simpleMessage("Title"),
        "exceptionInvalidResponseData": MessageLookupByLibrary.simpleMessage(
            "Invalid Response Data Exception"),
        "exceptionInvalidStatusCode": m0,
        "exceptionUnknown":
            MessageLookupByLibrary.simpleMessage("Unknown exception"),
        "genericErrorEmptyField":
            MessageLookupByLibrary.simpleMessage("Field cannot be empty"),
        "genericErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Something went wrong.. Please try again later."),
        "productActionDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "productActionEdit": MessageLookupByLibrary.simpleMessage("Edit"),
        "productAppBarTitle": MessageLookupByLibrary.simpleMessage("Sandman"),
        "productDeleteDialogCancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "productDeleteDialogConfirm":
            MessageLookupByLibrary.simpleMessage("Confirm"),
        "productDeleteDialogTitle": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this product?"),
        "productsAppBarTitle": MessageLookupByLibrary.simpleMessage("Sandman"),
        "updateProductAppBarTitle":
            MessageLookupByLibrary.simpleMessage("Update product"),
        "updateProductFloatingButtonTitle":
            MessageLookupByLibrary.simpleMessage("Update")
      };
}
