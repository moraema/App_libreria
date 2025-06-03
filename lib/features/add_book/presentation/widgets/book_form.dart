import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libreria/features/add_book/presentation/widgets/custom_input.dart';

class BookForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController authorController;
  final TextEditingController publicationController;
  final TextEditingController categoryController;
  final TextEditingController descriptionController;
  final TextEditingController quantityController;
  final TextEditingController locationController;
  final TextEditingController imageUrlController;

  const BookForm({
    Key? key,
    required this.titleController,
    required this.authorController,
    required this.publicationController,
    required this.categoryController,
    required this.descriptionController,
    required this.quantityController,
    required this.locationController,
    required this.imageUrlController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detalles del libro',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),
        CustomInput(
          label: 'Título',
          hint: 'Título aquí',
          icon: Icons.menu_book_outlined,
          controller: titleController,
        ),
        const SizedBox(height: 16),
        CustomInput(
          label: 'Autor',
          hint: 'Nombre del autor',
          icon: Icons.person_outline,
          controller: authorController,
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Publicación',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: publicationController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
                _DateInputFormatter(),
              ],
              decoration: InputDecoration(
                hintText: 'DD-MM-YYYY',
                filled: true,
                fillColor: const Color(0xFFF6F1ED),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.date_range_outlined, color: Colors.black45),
                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        CustomInput(
          label: 'Categoría',
          hint: 'Categoría aquí',
          icon: Icons.category_outlined,
          controller: categoryController,
        ),
        const SizedBox(height: 16),
        const Text(
          'Descripción',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: descriptionController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Descripción aquí',
            filled: true,
            fillColor: const Color(0xFFF6F1ED),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Inventario',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),
        CustomInput(
          label: 'Cantidad',
          hint: 'Cantidad aquí',
          icon: Icons.tag,
          controller: quantityController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        CustomInput(
          label: 'Ubicación',
          hint: 'Ubicación aquí',
          icon: Icons.location_on_outlined,
          controller: locationController,
        ),
        const SizedBox(height: 24),
        const Text(
          'Imagen del libro',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),
        CustomInput(
          label: 'URL de la imagen',
          hint: 'Pega la URL de la imagen aquí',
          icon: Icons.link,
          controller: imageUrlController,
        ),
      ],
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final text = newValue.text.replaceAll('-', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
} 