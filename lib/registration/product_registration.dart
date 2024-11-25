import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingmall_platform/models/product.dart';
import '../widgets/image_picker_button.dart';
import '../widgets/image_container.dart';
import '../widgets/delete_button.dart';
import '../widgets/representative_photo_label.dart';

class ProductRegistration extends StatefulWidget {
  final Function(Product) addProduct;

  const ProductRegistration({Key? key, required this.addProduct})
      : super(key: key);

  @override
  State<ProductRegistration> createState() => _ProductRegistrationState();
}

class _ProductRegistrationState extends State<ProductRegistration> {
  static const int maxImages = 10;
  static const double imageWidth = 200.0;
  static const double imageHeight = 200.0;

  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _pickImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage(
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 80,
    );

    if (selectedImages.isNotEmpty) {
      setState(() {
        _addNewImages(selectedImages);
      });
    }
  }

  void _addNewImages(List<XFile> selectedImages) {
    for (var image in selectedImages) {
      if (_images.length >= maxImages) break;
      if (!_isImageAlreadyAdded(image)) {
        _images.add(image);
      }
    }
  }

  bool _isImageAlreadyAdded(XFile image) {
    return _images.any((element) => element.path == image.path);
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _handleSubmit() {
    final String name = _nameController.text;
    final int? price = int.tryParse(_priceController.text);
    final String description = _descriptionController.text;
    final String location = _locationController.text;

    if (name.isEmpty ||
        price == null ||
        description.isEmpty ||
        location.isEmpty ||
        _images.isEmpty) {
      _showErrorMessage('모든 필드를 채워주세요');
      return;
    }

    final newProduct = Product(
      title: name,
      detail: description,
      price: price,
      images: _images,
      location: location,
    );

    widget.addProduct(newProduct);
    Navigator.pop(context);
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('물건 팔기'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: imageHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _images.length < maxImages
                    ? _images.length + 1
                    : _images.length,
                itemBuilder: (context, index) {
                  return index == _images.length && _images.length < maxImages
                      ? GestureDetector(
                          onTap: _pickImages, child: const ImagePickerButton())
                      : Stack(
                          children: [
                            ImageContainer(image: _images[index]),
                            DeleteButton(onTap: () => _removeImage(index)),
                            if (index == 0) const RepresentativePhotoLabel(),
                          ],
                        );
                },
              ),
            ),
            const SizedBox(height: 26),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInputField('상품 이름', _nameController, '상품 이름을 입력해주세요'),
                const SizedBox(height: 16),
                buildInputField('가격', _priceController, '가격을 입력해주세요',
                    keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                buildInputField(
                    '상품 설명', _descriptionController, '상세하게 상품을 설명해주세요',
                    maxLines: 6),
                const SizedBox(height: 16),
                buildInputField('위치', _locationController, '위치를 입력해주세요'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6E1D),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '작성 완료',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(
      String label, TextEditingController controller, String hintText,
      {TextInputType? keyboardType, int? maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines ?? 1,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              hintText: hintText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        ),
      ],
    );
  }
}
