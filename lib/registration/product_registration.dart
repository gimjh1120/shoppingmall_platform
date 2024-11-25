import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductRegistration extends StatefulWidget {
  const ProductRegistration({super.key});

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

  Future<void> _pickImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage(
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 80,
      limit: maxImages,
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

  Widget _buildImagePickerButton() {
    return GestureDetector(
      onTap: _pickImages,
      child: _ImagePickerButton(),
    );
  }

  Widget _buildImageItem(int index) {
    return Stack(
      children: [
        _ImageContainer(image: _images[index]),
        _DeleteButton(onTap: () => _removeImage(index)),
        if (index == 0) const _RepresentativePhotoLabel(),
      ],
    );
  }

  void _handleSubmit() {
    final String name = _nameController.text;
    final int? price = int.tryParse(_priceController.text);
    final String description = _descriptionController.text;

    if (price == null) {
      _showErrorMessage('올바른 가격을 입력해주세요');
      return;
    }

    _submitProduct(name, price, description);
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _submitProduct(String name, int price, String description) {
    // TODO: Implement actual product submission logic
    print('상품 이름: $name');
    print('가격: $price');
    print('상품 설명: $description');
    print('이미지 개수: ${_images.length}');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            const SizedBox(height: 26),
            _buildInputSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildSubmitButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('물건 팔기'),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      height: imageHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _images.length < maxImages ? _images.length + 1 : _images.length,
        itemBuilder: (context, index) {
          return index == _images.length && _images.length < maxImages
              ? _buildImagePickerButton()
              : _buildImageItem(index);
        },
      ),
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField('상품 이름', _nameController, '상품 이름을 입력해주세요'),
        const SizedBox(height: 16),
        _buildInputField('가격', _priceController, '가격을 입력해주세요', 
            keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        _buildInputField('상품 설명', _descriptionController, '상세하게 상품을 설명해주세요', 
            maxLines: 6),
      ],
    );
  }

  Widget _buildInputField(
    String label, 
    TextEditingController controller, 
    String hintText, {
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines ?? 1,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SafeArea(
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
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _ImagePickerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_photo_alternate_outlined, size: 40),
          const SizedBox(height: 8),
          Text(
            '사진은 최대 10장까지\n업로드 할 수 있습니다',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageContainer extends StatelessWidget {
  final XFile image;

  const _ImageContainer({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(image.path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final VoidCallback onTap;

  const _DeleteButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 8,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.close,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _RepresentativePhotoLabel extends StatelessWidget {
  const _RepresentativePhotoLabel();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        color: Colors.black.withOpacity(0.5),
        child: const Text(
          '대표사진',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
      ),
    );
  }
}