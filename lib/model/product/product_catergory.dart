class ProductCategory {
  final String id;
  final String name;
  final String? parentId;
  final String? parentName;

  ProductCategory({
    required this.id,
    required this.name,
    this.parentId,
    this.parentName,
  });

  static final List<ProductCategory> productCategories = [
    // Root container (focus on Electronics area)
    ProductCategory(
      id: '0',
      name: 'Electronics',
      parentId: null,
      parentName: null,
    ),

    // Level 1 (chips shown on Home): Smartphones / Watch / Headphones / ...
    ProductCategory(
      id: '1',
      name: 'Smartphones',
      parentId: '0',
      parentName: 'Electronics',
    ),
    ProductCategory(
      id: '2',
      name: 'Watch',
      parentId: '0',
      parentName: 'Electronics',
    ),
    ProductCategory(
      id: '3',
      name: 'Headphones',
      parentId: '0',
      parentName: 'Electronics',
    ),

    // Level 2 under Smartphones
    ProductCategory(
      id: '10',
      name: 'Gaming Phones',
      parentId: '1',
      parentName: 'Smartphones',
    ),
    ProductCategory(
      id: '11',
      name: 'Flagship Phones',
      parentId: '1',
      parentName: 'Smartphones',
    ),
    ProductCategory(
      id: '12',
      name: 'Budget Phones',
      parentId: '1',
      parentName: 'Smartphones',
    ),

    // Level 2 under Watch
    ProductCategory(
      id: '20',
      name: 'Smartwatches',
      parentId: '2',
      parentName: 'Watch',
    ),
    ProductCategory(
      id: '21',
      name: 'Smartbands',
      parentId: '2',
      parentName: 'Watch',
    ),

    // Level 2 under Headphones
    ProductCategory(
      id: '30',
      name: 'Wireless',
      parentId: '3',
      parentName: 'Headphones',
    ),
    ProductCategory(
      id: '31',
      name: 'Noise Cancelling',
      parentId: '3',
      parentName: 'Headphones',
    ),
    ProductCategory(
      id: '32',
      name: 'Gaming Headsets',
      parentId: '3',
      parentName: 'Headphones',
    ),
  ];

  static const String electronicsId = '0';

  /// Root chips to show for Electronics section (e.g. Smartphones / Watch / Headphones).
  static List<ProductCategory> get electronicsRootCategories =>
      productCategories.where((c) => c.parentId == electronicsId).toList();

  static List<ProductCategory> subCategoriesOf(String rootCategoryId) =>
      productCategories.where((c) => c.parentId == rootCategoryId).toList();
}
