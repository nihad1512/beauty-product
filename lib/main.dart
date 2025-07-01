import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() => runApp(const BeautyLandingPage());

// ✅ Send to Google Sheet
Future<void> submitToGoogleSheet({
  required String product,
  required String name,
  required String phone,
  required String size,
  required int quantity,
  required String willaya,
  required String delivery,
  required double price,
}) async {
  const String scriptURL =
      'https://script.google.com/macros/s/AKfycbzCd9n36L_0AiRWIFmQzNShLl3-u9-sE_W_pWenCy_fgl9kxCeWSCbcGUufQXqIMs-M/exec';

  double total = price * quantity;

  try {
    await http.post(
      Uri.parse(scriptURL),
      body: {
        'Produit': product,
        'Nom': name,
        'Phone Number': phone,
        'Size': size,
        'Quantity': quantity.toString(),
        'Willaya': willaya,
        'Delivery Location': delivery,
        'Price': price.toString(),
        'Total': total.toStringAsFixed(2),
      },
    );
  } catch (e) {
    print('Error sending data to Google Sheets: \$e');
  }
}

// ✅ Main Page
class BeautyLandingPage extends StatelessWidget {
  const BeautyLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beauty Landing Page',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              _buildHeroSection(),
              _buildFeaturedProducts(context),
              _buildSaleSection(),
              const SizedBox(height: 50),
              _buildInfoCards(context),
              const SizedBox(height: 50),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

//navbar
 Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20),
    color: Colors.white,
    child: Center(
      child: Text(
        '✨ Lush Beauty ✨',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.pinkAccent,
          letterSpacing: 1.5,
        ),
      ),
    ),
  );
}

//image kbira 
  Widget _buildHeroSection() {
    return Stack(
      children: [
        Image.asset(
          'assets/images/1.jpg',
          width: double.infinity,
          height: 540,
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 24),
            color: Colors.black.withOpacity(0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Glow like\nnever before!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 43,
                    color: const Color.fromARGB(255, 252, 251, 251),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                  ),
                  child: Text('Shop Now'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//cards
  Widget _buildFeaturedProducts(BuildContext context) {
    List<String> productNames = [
      "LIPSTICKS",
      "FOUNDATION",
      "SKINCARE",
      "POWDER",
      "SUNKISS",
      "GLOW KIT",
      "MOISTURIZER",
      "SERUM"
    ];

    List<List<String>> productImages = [
      ["assets/images/3.jpg", "assets/images/33.jpg", "assets/images/333.jpg"],
      ["assets/images/2.jpg", "assets/images/22.jpg", "assets/images/222.jpg"],
      ["assets/images/6.jpg", "assets/images/7.jpg"],
      ["assets/images/4.jpg", "assets/images/8.jpg"],
      ["assets/images/5.jpg", "assets/images/9.jpg"],
      ["assets/images/10.jpg", "assets/images/11.jpg"],
      ["assets/images/11.jpg", "assets/images/12.jpg"],
      ["assets/images/12.jpg", "assets/images/3.jpg"]
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Featured Product',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productNames.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailPage(
                        name: productNames[index],
                        imagePaths: productImages[index],
                        description: 'This is a beautiful ${productNames[index].toLowerCase()} product.',
                        price: 1999.0 + index * 500, category: '', categoryTitle: '', // Example price
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 140,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 119, 119, 119).withOpacity(0.3),
                        blurRadius: 6,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.asset(
                          productImages[index][0],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          productNames[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

//sold 
  Widget _buildSaleSection() {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isMobile = constraints.maxWidth < 600;

      return Container(
        color: const Color.fromARGB(255, 252, 213, 232),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: isMobile
            ? Column(
                children: [
                  Image.asset(
                    'assets/images/13.jpg',
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  _buildSaleTextAndButton(isCentered: true),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 5, child: _buildSaleTextAndButton(isCentered: false)),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 4,
                    child: Image.asset(
                      'assets/images/13.jpg',
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
      );
    },
  );
}
Widget _buildSaleTextAndButton({required bool isCentered}) {
  return Column(
    crossAxisAlignment:
        isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
    children: [
      Text(
        'Spring Beauty Sale',
        textAlign: isCentered ? TextAlign.left : TextAlign.start,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 10),
      Text(
        'Up to 40% Off',
        textAlign: isCentered ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          fontSize: 30,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        'Indulge in radiant beauty with up to 40% off our top skincare and makeup must-haves!',
        textAlign: isCentered ? TextAlign.center : TextAlign.start,
        style: const TextStyle(fontSize: 20, color: Colors.black54),
      ),
      const SizedBox(height: 20),
      Center(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text('SHOP NOW'),
        ),
      )
    ],
  );
}


//3cards
Widget _buildInfoCards(BuildContext context) {
  List<String> titles = [
    "BEAUTY CREAM",
    "ROSE EXTRACTS",
    "SKINCARE GUIDE"
  ];

  List<String> subtitles = [
    "Moisturizing and nourishing creams for all skin types.",
    "Natural rose ingredients for soft and fresh skin.",
    "Learn how to take care of your skin every day.",
  ];

  List<String> imagePaths = [
    'assets/images/7.jpg',
    'assets/images/8.jpg',
    'assets/images/9.jpg',
  ];

  return Center(
    child: Wrap(
      spacing: 25,
      runSpacing: 25,
      alignment: WrapAlignment.center,
      children: List.generate(titles.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(
                  category: titles[index], // Pass the category name
                  categoryTitle: titles[index], name: '', imagePaths: [], description: '', price: 0.0,
                ),
              ),
            );
          },
          child: Container(
            width: 260,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
              border: Border.all(color: Colors.pink.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    imagePaths[index],
                    height: 290,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        titles[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitles[index],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}

//contact
 Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xFFFFC0CB),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Contact us: beauty@brand.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.facebook, color: Colors.black),
              SizedBox(width: 16),
              FaIcon(FontAwesomeIcons.instagram, color: Colors.black),
              SizedBox(width: 16),
              FaIcon(FontAwesomeIcons.envelope, color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }
}

//info card produit
class ProductDetailPage extends StatefulWidget {
  final String name;
  final List<String> imagePaths;
  final String description;
  final double price;

  const ProductDetailPage({
    Key? key,
    required this.name,
    required this.imagePaths,
    required this.description,
    required this.price, required String category, required String categoryTitle,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}
class _ProductDetailPageState extends State<ProductDetailPage> {
  int _selectedImageIndex = 0;
  String _deliveryMethod = 'home';
  int _quantity = 1;
  String? _selectedSize;
  final List<String> _sizes = ['Small', 'Medium', 'Large'];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _willayaController = TextEditingController();

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedImageIndex, viewportFraction: 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updateQuantity(int delta) {
    setState(() {
      _quantity = (_quantity + delta).clamp(1, 99);
    });
  }

  InputDecoration inputDecoration(String label) => InputDecoration(
  labelText: label,
  isDense: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // أصغر قليلاً
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  labelStyle: TextStyle(fontSize: 16), // تصغير الخط
);


  @override
  Widget build(BuildContext context) {
    double total = widget.price * _quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: const Color.fromARGB(255, 243, 196, 211),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Images with navigation arrows and dots
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.imagePaths.length,
                        onPageChanged: (index) {
                          setState(() {
                            _selectedImageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                           margin: EdgeInsets.symmetric(horizontal: 0, 
                              vertical: _selectedImageIndex == index ? 0 : 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                if (_selectedImageIndex == index)
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(2, 4),
                                  ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                widget.imagePaths[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          if (_selectedImageIndex > 0) {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          if (_selectedImageIndex < widget.imagePaths.length - 1) {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.imagePaths.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _selectedImageIndex == index ? 12 : 8,
                      height: _selectedImageIndex == index ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedImageIndex == index ? Colors.pinkAccent : const Color.fromARGB(255, 253, 253, 253),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(widget.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('DA ${widget.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, color: Colors.pink)),
            SizedBox(height: 6),
            Text(widget.description, style: TextStyle(fontSize: 14)),
            SizedBox(height: 16),

           // Your Name
Align(
  alignment: Alignment.centerLeft,
  child: Container(
    width: 510,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(top: 16),
   decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color.fromARGB(255, 250, 101, 151).withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _nameController,
          textAlign: TextAlign.left,
          decoration: inputDecoration('Your Name'),
        ),
        SizedBox(height: 15),
        TextField(
          controller: _phoneController,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.phone,
          decoration: inputDecoration('Phone Number'),
        ),
        SizedBox(height: 15),
        TextField(
          controller: _willayaController,
          textAlign: TextAlign.left,
          decoration: inputDecoration('Willaya'),
        ),
        SizedBox(height: 15),
        DropdownButtonFormField<String>(
          decoration: inputDecoration('Size'),
          value: _selectedSize,
          onChanged: (value) => setState(() => _selectedSize = value),
          items: _sizes.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
        ),
        SizedBox(height: 15),
        Text('Quantity:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            IconButton(icon: Icon(Icons.remove), onPressed: () => _updateQuantity(-1)),
            Text('$_quantity', style: TextStyle(fontSize: 18)),
            IconButton(icon: Icon(Icons.add), onPressed: () => _updateQuantity(1)),
          ],
        ),
        SizedBox(height: 15),
        Text('Delivery Location:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Radio(
              value: 'home',
              groupValue: _deliveryMethod,
              onChanged: (value) => setState(() => _deliveryMethod = value!),
            ),
            Text('To Home'),
            Radio(
              value: 'office',
              groupValue: _deliveryMethod,
              onChanged: (value) => setState(() => _deliveryMethod = value!),
            ),
            Text('To Office'),
          ],
        ),
      ],
    ),
  ),
),
  // Total Price
SizedBox(height: 10),
Text(
  'Total: DA ${total.toStringAsFixed(2)}',
  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
),
SizedBox(height: 16),

// زر الطلب بمحاذاة اليسار
Align(
  alignment: Alignment.centerLeft,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 247, 148, 181),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    onPressed: () async {
  // تحقق من أن كل الحقول معمرة
  if (_nameController.text.isEmpty ||
      _phoneController.text.isEmpty ||
      _willayaController.text.isEmpty ||
      _selectedSize == null) {
    // إذا كاين شي ناقص، نعرض رسالة خطأ
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(' Incomplete information'),
        content: Text('Please fill in all fields before ordering.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Okay'),
          )
        ],
      ),
    );
    return; // نوقف التنفيذ
  }

  // إرسال الطلب
  await submitToGoogleSheet(
    product: widget.name,
    name: _nameController.text,
    phone: _phoneController.text,
    size: _selectedSize!,
    quantity: _quantity,
    willaya: _willayaController.text,
    delivery: _deliveryMethod,
    price: widget.price,
  );

  // رسالة نجاح
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('The request was successful.'),
      content: Text('Thank you for your order! Our team will contact you soon.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Okay'),
        ),
      ],
    ),
  );
},

    child: Text('Order Now', style: TextStyle(fontSize: 16)),
  ),
),
          ],
        ),
      ),
    );
  }
}