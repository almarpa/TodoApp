import 'package:flutter/material.dart';
import 'package:todo_app/app/presentation/widgets/custom_text_button.dart';
import 'package:todo_app/app/presentation/widgets/title_h1.dart';

class CustomBottomSheet extends StatefulWidget {
  final void Function(String) onPressed;

  const CustomBottomSheet({
    super.key,
    required this.onPressed,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Apply keyboard height as padding to do not hide modal during keyboard is active
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        bottom: keyboardHeight,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TitleH1(title: "Nueva tarea"),
            const SizedBox(height: 30),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  hintText: "Descripción"),
            ),
            const SizedBox(height: 50),
            CustomTextButton(
              onPressed: () => widget.onPressed(_controller.text),
              text: "Aceptar",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
