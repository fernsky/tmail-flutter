import 'package:core/presentation/views/text/text_form_field_builder.dart';
import 'package:flutter/material.dart';
import 'package:tmail_ui_user/features/login/presentation/widgets/login_input_decoration_builder.dart';

typedef OnSubmitted = void Function(String);

/// Password entry, shaped like bodhimail's `PasswordFormField`: obscured by
/// default with a show/hide toggle carried as the decoration's own
/// `suffixIcon`, rather than a separate button stacked on top of the field
/// and paid for with reserved trailing padding. Putting it in the decoration
/// is what lets the field size and align itself, and gives the toggle a
/// focus/hit target the framework manages.
class LoginTextInputBuilder extends StatefulWidget {
  final String? hintText;
  final String? prefixText;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<String>? autofillHints;
  final bool obscureText;
  final bool passwordInput;
  final ValueChanged<String>? onTextChange;
  final OnSubmitted? onSubmitted;

  const LoginTextInputBuilder({
    super.key,
    this.hintText,
    this.prefixText,
    this.textInputAction,
    this.focusNode,
    this.controller,
    this.autofillHints,
    this.onSubmitted,
    this.onTextChange,
    this.passwordInput = true,
    this.obscureText = true,
  });

  @override
  State<LoginTextInputBuilder> createState() => _LoginTextInputBuilderState();
}

class _LoginTextInputBuilderState extends State<LoginTextInputBuilder> {

  late TextEditingController _controller;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormFieldBuilder(
      onTextSubmitted: widget.onSubmitted,
      onTextChange: widget.onTextChange,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      controller: _controller,
      focusNode: widget.focusNode,
      // Stock M3 decoration, as on bodhimail's PasswordFormField: only the
      // label is specified and the seeded theme supplies the rest, so this
      // field matches the email field above it exactly.
      decoration: (LoginInputDecorationBuilder()
        ..setLabelText(widget.hintText)
        ..setPrefixText(widget.prefixText)
        ..setSuffixIcon(widget.passwordInput ? _buildObscureToggle() : null)
      ).build(),
    );
  }

  // Plain strings rather than localized keys, matching how the "Source code"
  // link on this screen is handled: a new key means regenerating
  // app_localizations.dart across all 17 catalogues. Worth revisiting if
  // these ever need translating.
  Widget _buildObscureToggle() {
    return IconButton(
      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
      tooltip: _obscureText ? 'Show password' : 'Hide password',
      onPressed: () => setState(() => _obscureText = !_obscureText),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
