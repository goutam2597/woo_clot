import 'package:flutter_woocommerce/app/assets_path.dart';
import 'package:flutter_woocommerce/features/categories/data/models/categories_model.dart';
import 'package:flutter_woocommerce/features/products/data/models/details_slider_model.dart';
import 'package:flutter_woocommerce/features/products/data/models/reviews_model.dart';
import 'package:flutter_woocommerce/features/products/data/models/variation_model.dart';

class ProductsModel {
  final String images;
  final String title;
  final String shortDetails;
  final String description;
  final String price;
  final String rating;
  final String review;
  final String discount;
  final String stock;
  final String discountPercentage;
  final CategoryListModel category;
  final List<DetailsSliderModel> sliderImages;
  final List<VariationModel> variations;
  final List<ReviewsModel> reviews;

  ProductsModel({
    required this.images,
    required this.title,
    required this.shortDetails,
    required this.description,
    required this.price,
    required this.rating,
    required this.review,
    required this.discount,
    required this.stock,
    required this.discountPercentage,
    required this.category,
    required this.sliderImages,
    required this.variations,
    required this.reviews,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      images: json['images'] ?? '',
      title: json['title'] ?? '',
      shortDetails: json['subTitle'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      rating: json['rating'] ?? '',
      review: json['review'] ?? '',
      discount: json['discount'] ?? '',
      discountPercentage: json['discountPercentage'] ?? '',
      stock: json['stock'] ?? '',
      category: CategoryListModel.fromJson(json['category'] ?? {}),
      variations: (json['variations'] as List<dynamic>? ?? [])
          .map((e) => VariationModel.fromJson(e))
          .toList(),
      sliderImages: (json['sliderImages'] as List<dynamic>? ?? [])
          .map((e) => DetailsSliderModel.fromJson(e))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((e) => ReviewsModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'images': images,
      'title': title,
      'subTitle': shortDetails,
      'description': description,
      'price': price,
      'rating': rating,
      'review': review,
      'discount': discount,
      'stock': stock,
      'discountPercentage': discountPercentage,
      'category': category.toJson(),
      'sliderImages': sliderImages.map((e) => e.toJson()).toList(),
      'variations': variations.map((e) => e.toJson()).toList(),
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
}

final List<ProductsModel> dummyProductList = [
  // 1. HD Action Camera (Cameras)
  ProductsModel(
    images: AssetsPath.cam1,
    title: 'HD Action Camera Pro',
    shortDetails:
        'Professional-grade 4K Ultra HD video with advanced stabilization, perfect for extreme sports.',
    description: '''
• Records in 4K/60fps and 1080p/240fps for cinematic slow-motion
• HyperSmooth 4.0 stabilization technology built-in
• Durable, waterproof up to 10m without a case (30m with case)
• Voice control and live streaming capabilities
• SuperView wide-angle lens for immersive shots
• Front-facing screen for vlogging and status checks
• Includes extra battery and 64GB MicroSD card
''',
    price: '349',
    rating: '4.8',
    review: '450',
    discount: '300',
    stock: '25',
    discountPercentage: '14%',
    category: CategoryListModel(images: AssetsPath.cam1, title: 'Cameras'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.cam1),
      DetailsSliderModel(imageUrl: AssetsPath.cam2),
      DetailsSliderModel(imageUrl: AssetsPath.gc1),
      DetailsSliderModel(imageUrl: AssetsPath.drone1),
    ],
    variations: [
      VariationModel(color: 'Black'),
      VariationModel(color: 'Gunmetal'),
      VariationModel(color: 'Silver'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-08-12',
        username: 'Ethan Hunt',
        userImage: AssetsPath.wt2,
        comment: 'Best stabilization I\'ve used! Footage looks professional.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-07-30',
        username: 'Jessica Alba',
        userImage: AssetsPath.wt3,
        comment:
            'Amazing for surfing and snorkeling. The voice commands are a lifesaver.',
        rating: '5',
      ),
    ],
  ),
  // 2. Wireless Headphones (Headphones)
  ProductsModel(
    images: AssetsPath.hp1,
    title: 'Acoustic Noise-Cancelling Headphones',
    shortDetails:
        'Supreme audio clarity and industry-leading noise cancellation for an unparalleled listening experience.',
    description: '''
• Proprietary Acoustic Noise Cancelling™ technology with 3 modes
• Lightweight design with superior comfort earcup material
• Up to 24 hours of non-stop playback on a full charge
• Quick 15-minute charge yields 3 hours of playtime
• Crystal-clear call quality via advanced microphone system
• EQ customization through the companion mobile app
• Wired mode support with included audio cable
''',
    price: '299',
    rating: '4.7',
    review: '1120',
    discount: '250',
    stock: '50',
    discountPercentage: '16%',
    category: CategoryListModel(images: AssetsPath.hp1, title: 'Headphones'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
      DetailsSliderModel(imageUrl: AssetsPath.hp2),
      DetailsSliderModel(imageUrl: AssetsPath.hp3),
      DetailsSliderModel(imageUrl: AssetsPath.sp1),
    ],
    variations: [
      VariationModel(color: 'Black', size: 'Standard'),
      VariationModel(color: 'Arctic White', size: 'Standard'),
      VariationModel(color: 'Midnight Blue', size: 'Standard'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-02',
        username: 'Sarah Chen',
        userImage: AssetsPath.cam1,
        comment:
            'Silence the world! Perfect for long flights and focusing on work.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-20',
        username: 'Alex Rivas',
        userImage: AssetsPath.cam2,
        comment:
            'Comfortable enough for a full workday. Audio quality is exceptional.',
        rating: '5',
      ),
    ],
  ),
  // 3. Ultra Slim Laptop (Laptops)
  ProductsModel(
    images: AssetsPath.lp1,
    title: '14-inch Creator Notebook',
    shortDetails:
        'Featherlight and powerful, featuring an OLED display and latest AMD Ryzen 9 processor for creators.',
    description: '''
• AMD Ryzen 9 7940HS processor with integrated graphics
• 32GB LPDDR5 RAM and 2TB Gen 4 SSD for extreme speed
• 14.0" 2.8K OLED display (90Hz refresh, 100% DCI-P3)
• CNC-milled aluminum chassis—less than 15mm thin
• Long-lasting 75Wh battery with 100W USB-C PD support
• Advanced vapor chamber cooling system
• Full suite of ports including USB4 and HDMI 2.1
''',
    price: '1899',
    rating: '4.9',
    review: '310',
    discount: '1700',
    stock: '15',
    discountPercentage: '10%',
    category: CategoryListModel(images: AssetsPath.lp1, title: 'Laptops'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.lp1),
      DetailsSliderModel(imageUrl: AssetsPath.lp2),
      DetailsSliderModel(imageUrl: AssetsPath.pc1),
      DetailsSliderModel(imageUrl: AssetsPath.pc2),
    ],
    variations: [
      VariationModel(size: '14 inch', color: 'Space Grey'),
      VariationModel(size: '14 inch', color: 'Mercury White'),
      VariationModel(size: '16 inch', color: 'Space Grey'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-07-18',
        username: 'Mia Khalifa',
        userImage: AssetsPath.lp2,
        comment:
            'The OLED screen is a game-changer for photo and video editing.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-07-02',
        username: 'David Lee',
        userImage: AssetsPath.wt1,
        comment:
            'Insane performance in a ridiculously thin body. Highly recommend!',
        rating: '5',
      ),
    ],
  ),
  // 4. Portable Bluetooth Speaker (Speakers)
  ProductsModel(
    images: AssetsPath.sp1,
    title: 'Rugged Outdoor Bluetooth Speaker',
    shortDetails:
        'Powerful 360° sound, deep bass, and 24-hour battery life, built to withstand any outdoor environment.',
    description: '''
• Full 360-degree high-fidelity audio output
• Enhanced bass technology via dual-passive radiators
• Certified IP67 dustproof and completely waterproof (floats!)
• Up to 24 hours of playtime on a single charge
• Built-in power bank to charge your phone via USB-A
• Connects multiple speakers for massive sound coverage
• Integrated shoulder strap for easy transport
''',
    price: '149',
    rating: '4.8',
    review: '1500',
    discount: '125',
    stock: '40',
    discountPercentage: '16%',
    category: CategoryListModel(images: AssetsPath.sp1, title: 'Speakers'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.sp1),
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
      DetailsSliderModel(imageUrl: AssetsPath.hp2),
      DetailsSliderModel(imageUrl: AssetsPath.hp3),
    ],
    variations: [
      VariationModel(color: 'Forest Green'),
      VariationModel(color: 'Desert Sand'),
      VariationModel(color: 'Stealth Black'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-01',
        username: 'Chris Nolan',
        userImage: AssetsPath.hp2,
        comment: 'Took it kayaking. Got dunked, kept playing. Impressive!',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-11',
        username: 'Emily Blunt',
        userImage: AssetsPath.cam1,
        comment: 'Sound is loud and the bass is punchy. Great speaker.',
        rating: '5',
      ),
    ],
  ),
  // 5. Android Tablet (Tablets)
  ProductsModel(
    images: AssetsPath.tab1,
    title: 'Advanced Productivity Tablet',
    shortDetails:
        'Large 12.4-inch display, S Pen support, and powerful Snapdragon processor for professional-grade productivity.',
    description: '''
• 12.4" Super AMOLED display with 120Hz refresh rate
• Snapdragon 8 Gen 2 for Galaxy optimized processor
• Seamless integration with DeX mode for desktop experience
• Quad speakers tuned by AKG with Dolby Atmos support
• Massive 10,090 mAh battery for all-day use
• Included S Pen with low-latency and magnetic attachment
• Front and rear ultra-wide cameras for stunning photos and video calls
''',
    price: '799',
    rating: '4.6',
    review: '280',
    discount: '699',
    stock: '35',
    discountPercentage: '13%',
    category: CategoryListModel(images: AssetsPath.tab1, title: 'Tablets'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.tab1),
      DetailsSliderModel(imageUrl: AssetsPath.tab2),
      DetailsSliderModel(imageUrl: AssetsPath.wt1),
      DetailsSliderModel(imageUrl: AssetsPath.wt2),
    ],
    variations: [
      VariationModel(storage: '128GB', color: 'Graphite'),
      VariationModel(storage: '256GB', color: 'Graphite'),
      VariationModel(storage: '128GB', color: 'Beige'),
      VariationModel(storage: '256GB', color: 'Beige'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-08-22',
        username: 'Sofia Perera',
        userImage: AssetsPath.tab2,
        comment:
            'DeX mode makes it a laptop replacement. S Pen is excellent for sketching.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-03',
        username: 'Javid Hussain',
        userImage: AssetsPath.sp1,
        comment: 'The display is stunning, perfect for movie watching.',
        rating: '4',
      ),
    ],
  ),
  // 6. Smart Fitness Watch (Watches)
  ProductsModel(
    images: AssetsPath.wt1,
    title: 'Premium Health & Wellness Smartwatch',
    shortDetails:
        'All-in-one health monitoring, advanced workout metrics, and seamless smart features in a sleek design.',
    description: '''
• ECG, Body Composition (BIA), and continuous heart rate monitoring
• Advanced sleep coaching with daily recommendations
• Sapphire crystal glass for superior scratch resistance
• Wear OS powered by Google for access to thousands of apps
• 5ATM + IP68 rating for swimming and high-impact activities
• Rotating bezel for intuitive navigation (physical or digital)
• Built-in GPS for distance, pace, and route tracking
''',
    price: '249',
    rating: '4.9',
    review: '1800',
    discount: '210',
    stock: '60',
    discountPercentage: '16%',
    category: CategoryListModel(images: AssetsPath.wt1, title: 'Watches'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.wt1),
      DetailsSliderModel(imageUrl: AssetsPath.wt2),
      DetailsSliderModel(imageUrl: AssetsPath.wt3),
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
    ],
    variations: [
      VariationModel(size: '40mm', color: 'Rose Gold'),
      VariationModel(size: '40mm', color: 'Silver'),
      VariationModel(size: '44mm', color: 'Black'),
      VariationModel(size: '44mm', color: 'Silver'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-05',
        username: 'Fariha Ali',
        userImage: AssetsPath.wt3,
        comment:
            'Love the body composition sensor. Great tool for tracking fitness progress.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-09',
        username: 'Omar Khan',
        userImage: AssetsPath.hp3,
        comment:
            'Battery life is decent for a full-featured smartwatch. Sleep tracking is very detailed.',
        rating: '5',
      ),
    ],
  ),
  // 7. Gaming Console (New Category - Gaming)
  ProductsModel(
    images: AssetsPath.gc1,
    title: 'Next-Gen Gaming Console',
    shortDetails:
        'Blazing-fast loading, 8K support, and a revolutionary controller that redefines immersion.',
    description: '''
• Custom 8-core CPU and 10.28 TFLOPS GPU for stunning graphics
• Ultra-high-speed SSD for near-instantaneous load times
• Ray tracing acceleration for realistic shadows and reflections
• DualSense controller with haptic feedback and adaptive triggers
• 3D Audio technology for deeply immersive soundscapes
• Backwards compatibility with thousands of titles
• Supports 120Hz output on compatible 4K displays
''',
    price: '499',
    rating: '4.9',
    review: '2500',
    discount: '450',
    stock: '80',
    discountPercentage: '10%',
    category: CategoryListModel(images: AssetsPath.gc1, title: 'Gaming'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.gc1),
      DetailsSliderModel(imageUrl: AssetsPath.lp2),
      DetailsSliderModel(imageUrl: AssetsPath.cam2),
      DetailsSliderModel(imageUrl: AssetsPath.hp2),
    ],
    variations: [
      VariationModel(storage: 'Standard Edition'),
      VariationModel(storage: 'Digital Edition'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-15',
        username: 'Zayn Malik',
        userImage: AssetsPath.tab2,
        comment:
            'The controller\'s haptics are incredible. Really feels like next gen.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-09-01',
        username: 'Gigi Hadid',
        userImage: AssetsPath.hp2,
        comment: 'So fast! No more waiting for games to load. Absolute beast.',
        rating: '5',
      ),
    ],
  ),
  // 8. Desktop PC (New Category - Computers)
  ProductsModel(
    images: AssetsPath.pc1,
    title: 'High-Performance Gaming Desktop',
    shortDetails:
        'Overclocked Intel i9, NVIDIA RTX 4090, and liquid cooling for extreme gaming and content creation.',
    description: '''
• Intel Core i9-14900K 24-Core Processor (unlocked)
• NVIDIA GeForce RTX 4090 24GB GDDR6X dedicated graphics
• 64GB DDR5-6000MHz RAM (upgradeable)
• 2TB NVMe M.2 SSD + 4TB HDD storage
• 360mm AIO Liquid Cooler with custom RGB fans
• Tempered glass side panel and tool-less access design
• Pre-loaded with Windows 11 Pro and performance tuning software
''',
    price: '3499',
    rating: '4.7',
    review: '150',
    discount: '3100',
    stock: '10',
    discountPercentage: '11%',
    category: CategoryListModel(images: AssetsPath.pc1, title: 'Computers'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.pc1),
      DetailsSliderModel(imageUrl: AssetsPath.pc2),
      DetailsSliderModel(imageUrl: AssetsPath.lp1),
      DetailsSliderModel(imageUrl: AssetsPath.lp2),
    ],
    variations: [
      VariationModel(size: 'i9/4090'),
      VariationModel(size: 'i7/4070'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-08-10',
        username: 'Jack Sparrow',
        userImage: AssetsPath.tab1,
        comment:
            'Handles 4K gaming like it\'s nothing. Very quiet under load too.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-07-25',
        username: 'Elizabeth Swan',
        userImage: AssetsPath.cam1,
        comment: 'Setup was simple, and the RGB lighting is beautiful.',
        rating: '4',
      ),
    ],
  ),
  // 9. Drone (New Category - Drones)
  ProductsModel(
    images: AssetsPath.drone1,
    title: 'Professional Folding Drone',
    shortDetails:
        'Foldable 8K camera drone with omnidirectional obstacle sensing and 45 minutes of flight time.',
    description: '''
• 8K Ultra HD camera with 3-axis mechanical gimbal
• Omnidirectional obstacle sensing for safe flight
• Max flight time of 45 minutes on a single battery
• 15km O3+ video transmission for long-range control
• MasterShots and automated cinematic flight modes
• Lightweight and foldable design for easy travel
• Includes Fly More Combo: extra batteries, charging hub, case
''',
    price: '1999',
    rating: '4.8',
    review: '500',
    discount: '1800',
    stock: '18',
    discountPercentage: '10%',
    category: CategoryListModel(images: AssetsPath.drone1, title: 'Drones'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.drone1),
      DetailsSliderModel(imageUrl: AssetsPath.cam1),
      DetailsSliderModel(imageUrl: AssetsPath.cam2),
      DetailsSliderModel(imageUrl: AssetsPath.gc1),
    ],
    variations: [
      VariationModel(color: 'Gray'),
      VariationModel(color: 'Black'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-18',
        username: 'Tony Stark',
        userImage: AssetsPath.wt2,
        comment:
            'Stable flight and the 8K footage is breathtaking. Best drone I\'ve owned.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-30',
        username: 'Bruce Banner',
        userImage: AssetsPath.wt3,
        comment:
            'Obstacle avoidance works perfectly. Great peace of mind for flying.',
        rating: '5',
      ),
    ],
  ),
  // 10. Smart Home Hub (New Category - Smart Home)
  ProductsModel(
    images: AssetsPath.hp2, // Reusing HP image for a home device
    title: 'Smart Home Hub with Display',
    shortDetails:
        'Central control for all smart devices, featuring a responsive touchscreen and powerful voice assistant.',
    description: '''
• 10-inch HD touchscreen display for dashboard control
• Integrated Zigbee, Z-Wave, and Wi-Fi hub
• Built-in camera for video calls and home monitoring
• High-quality stereo speakers for music and media
• Compatibility with over 10,000 smart devices
• Personalized routines and custom dashboards
• Privacy controls including a physical camera shutter
''',
    price: '199',
    rating: '4.5',
    review: '900',
    discount: '170',
    stock: '55',
    discountPercentage: '15%',
    category: CategoryListModel(images: AssetsPath.hp2, title: 'Smart Home'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.hp2),
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
      DetailsSliderModel(imageUrl: AssetsPath.sp1),
      DetailsSliderModel(imageUrl: AssetsPath.tab1),
    ],
    variations: [
      VariationModel(color: 'Charcoal'),
      VariationModel(color: 'Glacier'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-08',
        username: 'Clark Kent',
        userImage: AssetsPath.cam2,
        comment:
            'Managing all my lights and thermostats from one screen is fantastic.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-19',
        username: 'Lois Lane',
        userImage: AssetsPath.hp3,
        comment:
            'Video calls look great, and the sound for music is surprisingly good.',
        rating: '4',
      ),
    ],
  ),
  // 11. Wireless Earbuds (Headphones)
  ProductsModel(
    images: AssetsPath.hp3,
    title: 'True Wireless Sport Earbuds',
    shortDetails:
        'Secure fit, IPX5 sweat-proof rating, and dynamic audio for high-intensity workouts.',
    description: '''
• IPX5 water and sweat resistance with secure wingtips
• Powerful 12mm drivers for clear highs and deep bass
• Up to 8 hours playback, plus 24 hours from the charging case
• Environmental Noise Cancellation (ENC) for clear calls
• Touch controls for music, calls, and voice assistant
• Seamless pairing with Bluetooth 5.3
• Lightweight and ergonomically designed for long use
''',
    price: '99',
    rating: '4.7',
    review: '750',
    discount: '85',
    stock: '70',
    discountPercentage: '14%',
    category: CategoryListModel(images: AssetsPath.hp3, title: 'Headphones'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.hp3),
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
      DetailsSliderModel(imageUrl: AssetsPath.hp2),
      DetailsSliderModel(imageUrl: AssetsPath.sp1),
    ],
    variations: [
      VariationModel(color: 'Red'),
      VariationModel(color: 'Black'),
      VariationModel(color: 'Neon Green'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-12',
        username: 'Barry Allen',
        userImage: AssetsPath.lp2,
        comment:
            'Never fall out during a run. The bass is perfect for motivation.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-25',
        username: 'Iris West',
        userImage: AssetsPath.wt1,
        comment: 'Great sound quality and the charging case is very compact.',
        rating: '4',
      ),
    ],
  ),
  // 12. E-Reader (New Category - Tablets)
  ProductsModel(
    images: AssetsPath.tab2,
    title: 'E-Ink Tablet with Stylus',
    shortDetails:
        'Paper-like writing and reading experience with a comfortable front-lit display and long battery life.',
    description: '''
• 10.3-inch E Ink Carta 1200 screen (300 ppi resolution)
• Adjustable warm/cool front light technology
• Supports handwritten notes and PDF annotation with included stylus
• Thousands of hours of reading on a single charge
• Lightweight aluminum frame, only 5.8mm thick
• Large library support with access to major bookstores
• Waterproof design for reading in the bath or by the pool
''',
    price: '379',
    rating: '4.9',
    review: '400',
    discount: '340',
    stock: '30',
    discountPercentage: '10%',
    category: CategoryListModel(images: AssetsPath.tab2, title: 'Tablets'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.tab2),
      DetailsSliderModel(imageUrl: AssetsPath.tab1),
      DetailsSliderModel(imageUrl: AssetsPath.wt1),
      DetailsSliderModel(imageUrl: AssetsPath.wt2),
    ],
    variations: [
      VariationModel(storage: '64GB'),
      VariationModel(storage: '128GB'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-03',
        username: 'Peter Parker',
        userImage: AssetsPath.sp1,
        comment:
            'Perfect for academic papers. The writing latency is incredibly low.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-15',
        username: 'Mary Jane',
        userImage: AssetsPath.hp1,
        comment:
            'Comfortable to read for hours. The adjustable light is a must-have.',
        rating: '5',
      ),
    ],
  ),
  // 13. Security Camera (Cameras)
  ProductsModel(
    images: AssetsPath.cam2,
    title: 'Outdoor 4K Security Camera',
    shortDetails:
        'Ultra-clear 4K resolution, color night vision, and AI human/vehicle detection for superior home security.',
    description: '''
• True 4K (8MP) resolution for crystal-clear footage
• Full-color night vision with built-in spotlight
• Smart AI detection for people, vehicles, and pets
• Two-way audio communication via built-in mic and speaker
• Weatherproof IP67 rating and vandal-resistant housing
• Local (SD card) and cloud storage options
• Remote pan and tilt functionality
''',
    price: '180',
    rating: '4.6',
    review: '650',
    discount: '150',
    stock: '90',
    discountPercentage: '17%',
    category: CategoryListModel(images: AssetsPath.cam2, title: 'Cameras'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.cam2),
      DetailsSliderModel(imageUrl: AssetsPath.cam1),
      DetailsSliderModel(imageUrl: AssetsPath.gc1),
      DetailsSliderModel(imageUrl: AssetsPath.drone1),
    ],
    variations: [
      VariationModel(color: 'White'),
      VariationModel(color: 'Black'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-20',
        username: 'Jules Winnfield',
        userImage: AssetsPath.lp2,
        comment: 'Night vision in color is a game-changer. Excellent clarity.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-09-05',
        username: 'Vincent Vega',
        userImage: AssetsPath.wt1,
        comment: 'Easy to install and the app is very user-friendly.',
        rating: '4',
      ),
    ],
  ),
  // 14. Wireless Mouse (Computers)
  ProductsModel(
    images: AssetsPath.lp2, // Reusing Laptop image for a computer accessory
    title: 'Ergonomic Wireless Mouse',
    shortDetails:
        'Designed for all-day comfort with a vertical design and high-precision sensor for reduced wrist strain.',
    description: '''
• Advanced vertical ergonomic design for natural hand position
• High-precision 4000 DPI sensor for smooth tracking
• Connects up to 3 devices via Bluetooth or USB receiver
• Programmable buttons and custom shortcut settings
• Rechargeable battery provides up to 70 days of use
• Silent click technology for a quiet work environment
• Compatible with Windows, macOS, and Linux
''',
    price: '79',
    rating: '4.5',
    review: '320',
    discount: '65',
    stock: '110',
    discountPercentage: '18%',
    category: CategoryListModel(images: AssetsPath.lp2, title: 'Computers'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.lp2),
      DetailsSliderModel(imageUrl: AssetsPath.lp1),
      DetailsSliderModel(imageUrl: AssetsPath.pc1),
      DetailsSliderModel(imageUrl: AssetsPath.pc2),
    ],
    variations: [
      VariationModel(color: 'Graphite'),
      VariationModel(color: 'Off-White'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-08-01',
        username: 'Walter White',
        userImage: AssetsPath.hp3,
        comment:
            'My wrist pain is gone! The vertical design takes getting used to, but it\'s worth it.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-07-15',
        username: 'Jesse Pinkman',
        userImage: AssetsPath.cam1,
        comment:
            'Seamless switching between my desktop and laptop. Fast and accurate.',
        rating: '4',
      ),
    ],
  ),
  // 15. Gaming Headset (Headphones)
  ProductsModel(
    images: AssetsPath.hp1, // Reusing HP image
    title: 'Immersive Gaming Headset',
    shortDetails:
        '7.1 Surround Sound, Pro-Grade Noise Cancelling Mic, and lightweight comfort for marathon gaming sessions.',
    description: '''
• Custom 50mm high-density neodymium audio drivers
• HyperX 7.1 Surround Sound for pinpoint audio accuracy
• Detachable, unidirectional noise-cancelling microphone
• Memory foam ear cushions and lightweight aluminum frame
• On-ear volume and mute controls
• Wired (3.5mm) and wireless (2.4GHz USB) connection options
• Compatible with PC, PS5, Xbox, Switch, and mobile
''',
    price: '129',
    rating: '4.8',
    review: '950',
    discount: '110',
    stock: '65',
    discountPercentage: '15%',
    category: CategoryListModel(images: AssetsPath.hp1, title: 'Headphones'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
      DetailsSliderModel(imageUrl: AssetsPath.hp2),
      DetailsSliderModel(imageUrl: AssetsPath.hp3),
      DetailsSliderModel(imageUrl: AssetsPath.sp1),
    ],
    variations: [
      VariationModel(color: 'Black/Red'),
      VariationModel(color: 'White/Blue'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-25',
        username: 'Master Chief',
        userImage: AssetsPath.cam2,
        comment: 'Comfiest headset I\'ve worn. The mic clarity is top-tier.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-09-08',
        username: 'Cortana AI',
        userImage: AssetsPath.sp1,
        comment:
            'Pinpoint enemy locations easily with the surround sound. Essential gear.',
        rating: '5',
      ),
    ],
  ),
  // 16. Portable Monitor (Computers)
  ProductsModel(
    images: AssetsPath.pc2,
    title: '15.6" Portable USB-C Monitor',
    shortDetails:
        'FHD 1080p IPS display, ultra-slim design, perfect for extending your laptop screen on the go.',
    description: '''
• 15.6-inch Full HD (1920x1080) IPS panel
• Single USB-C cable for both power and video signal
• Ultra-slim 5mm profile and VESA mount compatible
• Built-in kickstand allows for portrait and landscape modes
• Blue light filter technology for eye comfort
• Mini HDMI input for connecting to gaming consoles or cameras
• Includes magnetic smart cover for protection
''',
    price: '199',
    rating: '4.4',
    review: '280',
    discount: '180',
    stock: '45',
    discountPercentage: '10%',
    category: CategoryListModel(images: AssetsPath.pc2, title: 'Computers'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.pc2),
      DetailsSliderModel(imageUrl: AssetsPath.pc1),
      DetailsSliderModel(imageUrl: AssetsPath.lp1),
      DetailsSliderModel(imageUrl: AssetsPath.lp2),
    ],
    variations: [
      VariationModel(size: '15.6 inch'),
      VariationModel(size: '17.3 inch'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-08-18',
        username: 'Sheldon Cooper',
        userImage: AssetsPath.tab2,
        comment:
            'Essential for my mobile coding setup. Excellent color reproduction.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-07-30',
        username: 'Leonard Hofstadter',
        userImage: AssetsPath.wt3,
        comment:
            'Plug-and-play simplicity. Works great with my MacBook and Steam Deck.',
        rating: '4',
      ),
    ],
  ),
  // 17. Fitness Tracker Band (Watches)
  ProductsModel(
    images: AssetsPath.wt2,
    title: 'Slim Fitness Tracker Band',
    shortDetails:
        'Compact fitness band with continuous heart rate monitoring, sleep tracking, and a week-long battery life.',
    description: '''
• Vivid AMOLED display with customizable watch faces
• 24/7 heart rate and blood oxygen (SpO2) monitoring
• Water resistance up to 50m (swim-proof)
• Tracks steps, distance, calories burned, and over 100 sports modes
• Up to 14 days of battery life on a single charge
• Receive notifications for calls, texts, and apps
• Lightweight and thin design for comfort during sleep
''',
    price: '49',
    rating: '4.7',
    review: '1900',
    discount: '40',
    stock: '120',
    discountPercentage: '18%',
    category: CategoryListModel(images: AssetsPath.wt2, title: 'Watches'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.wt2),
      DetailsSliderModel(imageUrl: AssetsPath.wt1),
      DetailsSliderModel(imageUrl: AssetsPath.wt3),
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
    ],
    variations: [
      VariationModel(color: 'Black'),
      VariationModel(color: 'Pink'),
      VariationModel(color: 'Orange'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-10',
        username: 'Eleven Hopper',
        userImage: AssetsPath.cam1,
        comment:
            'The battery life is unbelievable. Perfect for basic health tracking.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-28',
        username: 'Dustin Henderson',
        userImage: AssetsPath.hp2,
        comment:
            'Accurate sleep data and comfortable enough to wear all night.',
        rating: '5',
      ),
    ],
  ),
  // 18. Soundbar (Speakers)
  ProductsModel(
    images: AssetsPath.sp1, // Reusing Speaker image
    title: 'Dolby Atmos Soundbar',
    shortDetails:
        'Immersive 5.1.2 channel soundbar with up-firing speakers for cinematic, three-dimensional audio.',
    description: '''
• True 5.1.2 channel audio with up-firing drivers
• Wireless subwoofer for deep, rumbling bass
• Supports Dolby Atmos and DTS:X for 3D soundscapes
• HDMI eARC for high-quality, lossless audio transmission
• Built-in voice assistant compatibility
• Dedicated Game Mode for optimized gaming sound
• Sleek, low-profile design that fits under most TVs
''',
    price: '599',
    rating: '4.6',
    review: '350',
    discount: '520',
    stock: '20',
    discountPercentage: '13%',
    category: CategoryListModel(images: AssetsPath.sp1, title: 'Speakers'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.sp1),
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
      DetailsSliderModel(imageUrl: AssetsPath.hp2),
      DetailsSliderModel(imageUrl: AssetsPath.hp3),
    ],
    variations: [VariationModel(color: 'Black')],
    reviews: [
      ReviewsModel(
        date: '2025-09-01',
        username: 'Rick Grimes',
        userImage: AssetsPath.cam2,
        comment:
            'The vertical sound from the Atmos effect is incredible for movies.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-14',
        username: 'Michonne',
        userImage: AssetsPath.sp1,
        comment:
            'Simple setup and the bass is powerful without being overpowering.',
        rating: '4',
      ),
    ],
  ),
  // 19. Power Bank (New Category - Accessories)
  ProductsModel(
    images: AssetsPath.tab1, // Reusing Tablet image
    title: '20000mAh PD Power Bank',
    shortDetails:
        'High-capacity power bank with 65W Power Delivery for charging laptops, tablets, and phones quickly.',
    description: '''
• Massive 20,000mAh capacity (up to 4-5 phone charges)
• 65W USB-C Power Delivery (PD) output for laptop charging
• Two USB-C ports and one USB-A port for simultaneous charging
• Digital LED display shows remaining battery percentage
• Multi-protection safety system (over-charge, short-circuit protection)
• Airplane-friendly design (meets most airline restrictions)
• Sleek aluminum shell for superior heat dissipation
''',
    price: '89',
    rating: '4.8',
    review: '1200',
    discount: '75',
    stock: '150',
    discountPercentage: '16%',
    category: CategoryListModel(images: AssetsPath.tab1, title: 'Accessories'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.tab1),
      DetailsSliderModel(imageUrl: AssetsPath.tab2),
      DetailsSliderModel(imageUrl: AssetsPath.wt1),
      DetailsSliderModel(imageUrl: AssetsPath.wt2),
    ],
    variations: [
      VariationModel(color: 'Black'),
      VariationModel(color: 'Navy Blue'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-11',
        username: 'Michael Scott',
        userImage: AssetsPath.lp1,
        comment:
            'Charges my work laptop and phone at the same time. Never leaves my bag.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-27',
        username: 'Dwight Schrute',
        userImage: AssetsPath.wt2,
        comment:
            'Reliable and fast. A necessary tool for survival in the modern office.',
        rating: '5',
      ),
    ],
  ),
  // 20. Smart Scale (Smart Home)
  ProductsModel(
    images: AssetsPath.wt3,
    title: 'Smart Body Composition Scale',
    shortDetails:
        'Measures 15 body metrics including weight, BMI, muscle mass, and body fat, syncing data via Wi-Fi.',
    description: '''
• Tracks 15 essential body composition metrics
• High-precision sensors with BIA technology
• Syncs data automatically to a mobile app via Wi-Fi and Bluetooth
• Supports multiple user profiles (up to 16 users)
• Athlete Mode for optimized measurement accuracy
• Large, easy-to-read LED display
• Tempered glass surface that is easy to clean
''',
    price: '69',
    rating: '4.5',
    review: '550',
    discount: '60',
    stock: '85',
    discountPercentage: '13%',
    category: CategoryListModel(images: AssetsPath.wt3, title: 'Smart Home'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.wt3),
      DetailsSliderModel(imageUrl: AssetsPath.wt1),
      DetailsSliderModel(imageUrl: AssetsPath.wt2),
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
    ],
    variations: [
      VariationModel(color: 'White'),
      VariationModel(color: 'Black'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-07',
        username: 'Leslie Knope',
        userImage: AssetsPath.hp3,
        comment:
            'Love the detailed metrics! Great for staying on track with my fitness goals.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-21',
        username: 'Ron Swanson',
        userImage: AssetsPath.cam1,
        comment: 'It measures the body. It works. Not overly complicated.',
        rating: '4',
      ),
    ],
  ),
  // 21. WiFi Mesh System (Smart Home)
  ProductsModel(
    images: AssetsPath.lp1, // Reusing Laptop image
    title: 'Tri-Band Mesh WiFi 6 System',
    shortDetails:
        'Whole-home coverage up to 6,000 sq. ft. with ultra-fast WiFi 6 and tri-band technology for zero buffering.',
    description: '''
• True Tri-Band technology (2.4GHz, 5GHz-1, 5GHz-2)
• Coverage up to 6,000 sq. ft. with three units
• Supports up to 100+ connected devices simultaneously
• AX5400 speed rating for 4K/8K streaming and gaming
• Easy setup and management via a mobile app
• Built-in parental controls and network security features
• 3 Gigabit Ethernet ports per unit for wired devices
''',
    price: '399',
    rating: '4.7',
    review: '700',
    discount: '350',
    stock: '30',
    discountPercentage: '12%',
    category: CategoryListModel(images: AssetsPath.lp1, title: 'Smart Home'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.lp1),
      DetailsSliderModel(imageUrl: AssetsPath.lp2),
      DetailsSliderModel(imageUrl: AssetsPath.pc1),
      DetailsSliderModel(imageUrl: AssetsPath.pc2),
    ],
    variations: [
      VariationModel(size: '2-Pack'),
      VariationModel(size: '3-Pack'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-17',
        username: 'Sheldon Cooper',
        userImage: AssetsPath.tab2,
        comment:
            'Finally, consistent speeds across my entire multi-story residence. A logical improvement.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-09-04',
        username: 'Leonard Hofstadter',
        userImage: AssetsPath.wt1,
        comment: 'No more dead zones! Streaming in the garage is now flawless.',
        rating: '5',
      ),
    ],
  ),
  // 22. Portable SSD (Accessories)
  ProductsModel(
    images: AssetsPath.gc1, // Reusing Gaming Console image
    title: '1TB Rugged Portable SSD',
    shortDetails:
        'Blazing-fast transfer speeds up to 1050MB/s, IP55 water/dust resistant, and shockproof.',
    description: '''
• Up to 1050MB/s read and 1000MB/s write speeds
• Durable silicone shell with IP55 water and dust resistance
• Shock-resistant core to withstand drops up to 2 meters
• USB 3.2 Gen 2 connectivity via USB-C port
• Includes USB-C to C and USB-C to A cables
• Hardware encryption for secure data storage
• Compact and lightweight, easily fits in a pocket
''',
    price: '129',
    rating: '4.9',
    review: '600',
    discount: '110',
    stock: '100',
    discountPercentage: '15%',
    category: CategoryListModel(images: AssetsPath.gc1, title: 'Accessories'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.gc1),
      DetailsSliderModel(imageUrl: AssetsPath.lp2),
      DetailsSliderModel(imageUrl: AssetsPath.cam2),
      DetailsSliderModel(imageUrl: AssetsPath.hp2),
    ],
    variations: [
      VariationModel(storage: '500GB'),
      VariationModel(storage: '1TB'),
      VariationModel(storage: '2TB'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-08-29',
        username: 'Indiana Jones',
        userImage: AssetsPath.wt2,
        comment:
            'Fast enough to edit 4K video directly from the drive. Very rugged!',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-16',
        username: 'Lara Croft',
        userImage: AssetsPath.wt3,
        comment:
            'Perfect for backing up my adventure photos. Small and reliable.',
        rating: '5',
      ),
    ],
  ),
  // 23. Gaming Keyboard (Computers)
  ProductsModel(
    images: AssetsPath.pc1, // Reusing PC image
    title: 'Mechanical Gaming Keyboard (TKL)',
    shortDetails:
        'Tenkeyless design, tactile brown switches, and customizable RGB lighting for competitive play.',
    description: '''
• Tenkeyless (TKL) 87-key layout saves desk space
• Responsive tactile brown mechanical switches
• Full N-Key Rollover (NKRO) for flawless input registration
• Per-key RGB backlighting with millions of colors
• Durable aluminum top plate construction
• Detachable USB-C cable for portability
• Includes wrist rest and keycap puller
''',
    price: '119',
    rating: '4.7',
    review: '450',
    discount: '100',
    stock: '75',
    discountPercentage: '16%',
    category: CategoryListModel(images: AssetsPath.pc1, title: 'Computers'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.pc1),
      DetailsSliderModel(imageUrl: AssetsPath.pc2),
      DetailsSliderModel(imageUrl: AssetsPath.lp1),
      DetailsSliderModel(imageUrl: AssetsPath.lp2),
    ],
    variations: [
      VariationModel(color: 'Black', size: 'Brown Switches'),
      VariationModel(color: 'Black', size: 'Red Switches'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-19',
        username: 'Tyler Blevins',
        userImage: AssetsPath.tab1,
        comment:
            'Great feel and responsiveness. The TKL size is perfect for my gaming setup.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-09-02',
        username: 'Shroud',
        userImage: AssetsPath.cam1,
        comment: 'Solid build quality. Fast shipping.',
        rating: '4',
      ),
    ],
  ),
  // 24. Instant Camera (Cameras)
  ProductsModel(
    images: AssetsPath.cam1, // Reusing Camera image
    title: 'Hybrid Instant Camera',
    shortDetails:
        'A retro-style instant camera that also lets you select, edit, and print photos from your phone.',
    description: '''
• Captures digital images and prints instantly
• 10 lens and 10 film effects for creative shots
• Bluetooth connectivity to print photos from your smartphone
• Mini screen for previewing and selecting images before printing
• Self-timer and built-in flash for perfect lighting
• Rechargeable battery via micro-USB
• Compact, stylish, and easily portable
''',
    price: '179',
    rating: '4.6',
    review: '880',
    discount: '150',
    stock: '55',
    discountPercentage: '16%',
    category: CategoryListModel(images: AssetsPath.cam1, title: 'Cameras'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.cam1),
      DetailsSliderModel(imageUrl: AssetsPath.cam2),
      DetailsSliderModel(imageUrl: AssetsPath.gc1),
      DetailsSliderModel(imageUrl: AssetsPath.drone1),
    ],
    variations: [
      VariationModel(color: 'Blush Gold'),
      VariationModel(color: 'Stone White'),
      VariationModel(color: 'Dark Denim'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-08-24',
        username: 'Emma Stone',
        userImage: AssetsPath.wt2,
        comment:
            'Best of both worlds! I love being able to edit before printing.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-07-19',
        username: 'Ryan Gosling',
        userImage: AssetsPath.wt3,
        comment: 'Fun for parties and the prints are great quality.',
        rating: '4',
      ),
    ],
  ),
  // 25. True Wireless Open-Ear Headphones (Headphones)
  ProductsModel(
    images: AssetsPath.hp2, // Reusing HP image
    title: 'Open-Ear Bone Conduction Headphones',
    shortDetails:
        'Listen to music while remaining aware of your surroundings—perfect for running, biking, and outdoor safety.',
    description: '''
• Bone conduction technology delivers audio through the cheekbone
• Keeps ear canal completely open for situational awareness
• IP67 waterproof rating (submersible for short periods)
• Up to 8 hours of continuous music and calls
• Lightweight titanium frame for comfortable, stable fit
• Dual noise-canceling mics for clear calls
• Quick-charge function: 10 mins for 1.5 hours of listening
''',
    price: '159',
    rating: '4.7',
    review: '620',
    discount: '135',
    stock: '60',
    discountPercentage: '15%',
    category: CategoryListModel(images: AssetsPath.hp2, title: 'Headphones'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.hp2),
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
      DetailsSliderModel(imageUrl: AssetsPath.hp3),
      DetailsSliderModel(imageUrl: AssetsPath.sp1),
    ],
    variations: [
      VariationModel(color: 'Cosmic Black'),
      VariationModel(color: 'Lunar Grey'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-09',
        username: 'Forrest Gump',
        userImage: AssetsPath.cam2,
        comment:
            'Excellent for my morning runs. I can hear the traffic clearly.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-23',
        username: 'Jenny Curran',
        userImage: AssetsPath.hp3,
        comment: 'Comfortable to wear with glasses. Clear sound quality.',
        rating: '5',
      ),
    ],
  ),
  // 26. 4K Streaming Stick (Smart Home)
  ProductsModel(
    images: AssetsPath.sp1, // Reusing Speaker image
    title: 'Ultra HD 4K Streaming Stick',
    shortDetails:
        'Stream in brilliant 4K Ultra HD with Dolby Vision and Dolby Atmos support, powered by the latest OS.',
    description: '''
• Streams in 4K Ultra HD, HDR, HDR10+, and Dolby Vision
• Supports immersive sound with Dolby Atmos
• Faster processor for quick app launches and navigation
• Voice remote with dedicated buttons for streaming services
• Access to thousands of movies, TV episodes, and apps
• Easy plug-in setup via HDMI port
• Small, discrete design hides behind the TV
''',
    price: '49',
    rating: '4.8',
    review: '2100',
    discount: '40',
    stock: '180',
    discountPercentage: '18%',
    category: CategoryListModel(images: AssetsPath.sp1, title: 'Smart Home'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.sp1),
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
      DetailsSliderModel(imageUrl: AssetsPath.hp2),
      DetailsSliderModel(imageUrl: AssetsPath.hp3),
    ],
    variations: [
      VariationModel(size: '4K Max'),
      VariationModel(size: 'HD Lite'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-21',
        username: 'Ted Lasso',
        userImage: AssetsPath.hp2,
        comment:
            'Super responsive and the picture quality is outstanding. Believe!',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-09-06',
        username: 'Coach Beard',
        userImage: AssetsPath.cam1,
        comment: 'Great value for 4K streaming. Easy setup.',
        rating: '4',
      ),
    ],
  ),
  // 27. Graphics Tablet (Accessories)
  ProductsModel(
    images: AssetsPath.tab2, // Reusing Tablet image
    title: 'Professional Graphics Drawing Tablet',
    shortDetails:
        'Large active area, 8192 levels of pressure sensitivity, and tilt support for digital artists.',
    description: '''
• 16-inch high-resolution display with anti-glare film
• 8192 levels of pressure sensitivity and 60° tilt function
• Battery-free pen eliminates charging downtime
• 10 customizable press keys and a touch strip for zooming
• USB-C and HDMI connectivity options
• Compatible with major design software (Photoshop, Illustrator)
• Includes adjustable stand and various pen nibs
''',
    price: '450',
    rating: '4.8',
    review: '300',
    discount: '400',
    stock: '22',
    discountPercentage: '11%',
    category: CategoryListModel(images: AssetsPath.tab2, title: 'Accessories'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.tab2),
      DetailsSliderModel(imageUrl: AssetsPath.tab1),
      DetailsSliderModel(imageUrl: AssetsPath.wt1),
      DetailsSliderModel(imageUrl: AssetsPath.wt2),
    ],
    variations: [
      VariationModel(size: '16 inch'),
      VariationModel(size: '22 inch'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-08-10',
        username: 'Bob Ross',
        userImage: AssetsPath.sp1,
        comment: 'Happy little pressure sensitivity! Drawing on this is a joy.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-07-25',
        username: 'Frida Kahlo',
        userImage: AssetsPath.hp1,
        comment:
            'The tilt function is essential for shading. Excellent tool for pros.',
        rating: '5',
      ),
    ],
  ),
  // 28. Smart Ring (Watches)
  ProductsModel(
    images: AssetsPath.wt1, // Reusing Watch image
    title: 'Oura Smart Sleep and Health Ring',
    shortDetails:
        'Advanced sleep tracking, activity monitoring, and readiness scores delivered from a lightweight, stylish ring.',
    description: '''
• Tracks sleep stages, body temperature, and resting heart rate
• Provides a daily "Readiness Score" to guide activity levels
• Continuous heart rate and movement tracking
• Lightweight and durable titanium build
• Up to 7 days of battery life on a single charge
• Water-resistant for swimming and showering
• Data synced securely to the companion app
''',
    price: '299',
    rating: '4.5',
    review: '1100',
    discount: '250',
    stock: '50',
    discountPercentage: '16%',
    category: CategoryListModel(images: AssetsPath.wt1, title: 'Watches'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.wt1),
      DetailsSliderModel(imageUrl: AssetsPath.wt2),
      DetailsSliderModel(imageUrl: AssetsPath.wt3),
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
    ],
    variations: [
      VariationModel(color: 'Silver'),
      VariationModel(color: 'Black'),
      VariationModel(color: 'Gold'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-14',
        username: 'Oprah Winfrey',
        userImage: AssetsPath.wt3,
        comment:
            'My sleep quality has improved significantly since using this. Highly recommended.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-08-05',
        username: 'Bill Gates',
        userImage: AssetsPath.hp3,
        comment: 'Discreet and powerful. Excellent health metrics.',
        rating: '4',
      ),
    ],
  ),
  // 29. Mini Projector (Cameras)
  ProductsModel(
    images: AssetsPath.cam2, // Reusing Camera image
    title: 'Portable Mini Smart Projector',
    shortDetails:
        'Full HD 1080p supported, built-in smart TV OS, and a 360-degree speaker for an on-the-go cinema experience.',
    description: '''
• Projects up to 100-inch screen size
• Supports 1080p resolution with auto keystone correction
• Built-in Smart TV OS for streaming apps
• 360-degree sound speaker for rich audio
• HDMI and USB inputs for external devices
• Long-lasting LED light source (30,000+ hours)
• Compact size and lightweight for easy travel
''',
    price: '399',
    rating: '4.4',
    review: '420',
    discount: '350',
    stock: '35',
    discountPercentage: '12%',
    category: CategoryListModel(images: AssetsPath.cam2, title: 'Cameras'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.cam2),
      DetailsSliderModel(imageUrl: AssetsPath.cam1),
      DetailsSliderModel(imageUrl: AssetsPath.gc1),
      DetailsSliderModel(imageUrl: AssetsPath.drone1),
    ],
    variations: [
      VariationModel(color: 'White'),
      VariationModel(color: 'Dark Grey'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-18',
        username: 'Steven Spielberg',
        userImage: AssetsPath.lp2,
        comment:
            'Amazing picture quality for such a small device. Perfect for backyard movie nights.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-09-01',
        username: 'George Lucas',
        userImage: AssetsPath.wt1,
        comment:
            'Easy to set up and the built-in speaker is surprisingly good.',
        rating: '4',
      ),
    ],
  ),
  // 30. Wireless Charging Pad (Accessories)
  ProductsModel(
    images: AssetsPath.wt2, // Reusing Watch image
    title: '3-in-1 Fast Wireless Charging Station',
    shortDetails:
        'Simultaneously charge your phone, smartwatch, and earbuds with up to 15W fast wireless charging.',
    description: '''
• Dedicated 15W fast wireless charging pad for smartphone
• Separate magnetic charging spot for smartwatch
• Third charging spot optimized for wireless earbuds case
• Sleek, modern design with a small desktop footprint
• LED indicator lights show charging status
• Foreign Object Detection (FOD) for safety
• Includes QC 3.0 wall adapter and USB-C cable
''',
    price: '59',
    rating: '4.7',
    review: '1500',
    discount: '49',
    stock: '200',
    discountPercentage: '17%',
    category: CategoryListModel(images: AssetsPath.wt2, title: 'Accessories'),
    sliderImages: [
      DetailsSliderModel(imageUrl: AssetsPath.wt2),
      DetailsSliderModel(imageUrl: AssetsPath.wt1),
      DetailsSliderModel(imageUrl: AssetsPath.wt3),
      DetailsSliderModel(imageUrl: AssetsPath.hp1),
    ],
    variations: [
      VariationModel(color: 'White'),
      VariationModel(color: 'Black'),
    ],
    reviews: [
      ReviewsModel(
        date: '2025-09-22',
        username: 'Jeff Bezos',
        userImage: AssetsPath.cam1,
        comment:
            'A clean and efficient way to charge all my essential devices. Excellent.',
        rating: '5',
      ),
      ReviewsModel(
        date: '2025-09-10',
        username: 'Elon Musk',
        userImage: AssetsPath.hp2,
        comment: 'Less clutter, faster charging. It does the job well.',
        rating: '5',
      ),
    ],
  ),
];
