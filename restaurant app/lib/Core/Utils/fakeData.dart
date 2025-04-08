import 'dart:math';

import 'package:mika_treeview/mika_treeview.dart';


class FakeData{

  final Tree tree = Tree(
    nodes: [
      Node(
        id: '1',
        name: 'الكترونيات',
        children: [
          Node(
            id: '2',
            name: 'لاب توب',
            children: [
              Node(
                id: '27',
                name: 'Apple',children: [

                  Node(id: '100', name: 'Apple M1'),
                  Node(id: '101', name: 'Apple Intel'),
              ]
              ),
              Node(
                id: '28',
                name: 'Dell',
              ),
              Node(
                id: '29',
                name: 'HP',
              ),
            ],
          ),
          Node(
            id: '3',
            name: 'موبايل',
            children: [
              Node(
                id: '30',
                name: 'Samsung',
              ),
              Node(
                id: '31',
                name: 'Apple iPhone',
              ),
              Node(
                id: '32',
                name: 'Huawei',
              ),
            ],
          ),
          Node(
            id: '4',
            name: 'تلفزيونات',
            children: [
              Node(
                id: '33',
                name: 'Samsung',
              ),
              Node(
                id: '34',
                name: 'LG',
              ),
              Node(
                id: '35',
                name: 'Sony',
              ),
            ],
          ),
          Node(
            id: '5',
            name: 'كاميرات',
            children: [
              Node(
                id: '36',
                name: 'Canon',
              ),
              Node(
                id: '37',
                name: 'Nikon',
              ),
              Node(
                id: '38',
                name: 'Sony Alpha',
              ),
            ],
          ),
          Node(
            id: '6',
            name: 'ألعاب فيديو',
            children: [
              Node(
                id: '39',
                name: 'Sony PlayStation',
              ),
              Node(
                id: '40',
                name: 'Microsoft Xbox',
              ),
              Node(
                id: '41',
                name: 'Nintendo',
              ),
            ],
          ),
        ],
      ),
      Node(
        id: '7',
        name: 'المنزل والمطبخ',
        children: [
          Node(
            id: '8',
            name: 'أدوات المطبخ',
            children: [
              Node(
                id: '42',
                name: 'Tefal',
              ),
              Node(
                id: '43',
                name: 'Philips',
              ),
              Node(
                id: '44',
                name: 'KitchenAid',
              ),
            ],
          ),
          Node(
            id: '11',
            name: 'أجهزة منزلية',
            children: [
              Node(
                id: '45',
                name: 'Samsung',
              ),
              Node(
                id: '46',
                name: 'Bosch',
              ),
              Node(
                id: '47',
                name: 'Siemens',
              ),
            ],
          ),
          Node(
            id: '14',
            name: 'أثاث المنزل',
            children: [
              Node(
                id: '48',
                name: 'IKEA',
              ),
              Node(
                id: '49',
                name: 'Ashley Furniture',
              ),
              Node(
                id: '50',
                name: 'Home Centre',
              ),
            ],
          ),
        ],
      ),
      Node(
        id: '17',
        name: 'الأزياء والملابس',
        children: [
          Node(
            id: '18',
            name: 'أحذية رجالية',
            children: [
              Node(
                id: '51',
                name: 'Nike',
              ),
              Node(
                id: '52',
                name: 'Adidas',
              ),
              Node(
                id: '53',
                name: 'Clarks',
              ),
            ],
          ),
          Node(
            id: '19',
            name: 'فساتين نسائية',
            children: [
              Node(
                id: '54',
                name: 'Zara',
              ),
              Node(
                id: '55',
                name: 'H&M',
              ),
              Node(
                id: '56',
                name: 'Mango',
              ),
            ],
          ),
          Node(
            id: '20',
            name: 'أزياء أطفال',
            children: [
              Node(
                id: '57',
                name: 'Carter\'s',
              ),
              Node(
                id: '58',
                name: 'Mothercare',
              ),
              Node(
                id: '59',
                name: 'Gap Kids',
              ),
            ],
          ),
          Node(
            id: '21',
            name: 'إكسسوارات',
            children: [
              Node(
                id: '60',
                name: 'Pandora',
              ),
              Node(
                id: '61',
                name: 'Swarovski',
              ),
              Node(
                id: '62',
                name: 'Louis Vuitton',
              ),
            ],
          ),
        ],
      ),
      Node(
        id: '22',
        name: 'الجمال والعناية الشخصية',
        children: [
          Node(
            id: '23',
            name: 'عطور',
            children: [
              Node(
                id: '63',
                name: 'Chanel',
              ),
              Node(
                id: '64',
                name: 'Dior',
              ),
              Node(
                id: '65',
                name: 'Tom Ford',
              ),
            ],
          ),
          Node(
            id: '24',
            name: 'مكياج',
            children: [
              Node(
                id: '66',
                name: 'MAC Cosmetics',
              ),
              Node(
                id: '67',
                name: 'L\'Oréal',
              ),
              Node(
                id: '68',
                name: 'Maybelline',
              ),
            ],
          ),
          Node(
            id: '25',
            name: 'مستحضرات العناية بالبشرة',
            children: [
              Node(
                id: '69',
                name: 'Neutrogena',
              ),
              Node(
                id: '70',
                name: 'The Body Shop',
              ),
              Node(
                id: '71',
                name: 'Clinique',
              ),
            ],
          ),
          Node(
            id: '26',
            name: 'مستحضرات الشعر',
            children: [
              Node(
                id: '72',
                name: 'L\'Oréal Professionnel',
              ),
              Node(
                id: '73',
                name: 'Pantene',
              ),
              Node(
                id: '74',
                name: 'Tresemmé',
              ),
            ],
          ),
        ],
      ),
    ],
  );
  List<String> imgs = [
  'assets/imgs/1.png',
  'assets/imgs/2.png',
  'assets/imgs/3.png'
];List<String> bannerImgs = [
  'assets/imgs/b1.png',
  'assets/imgs/b2.png',
  'assets/imgs/b3.png'
];

String getRandomPrice() {
  var random = Random();
  int randomNumber = random.nextInt(100) + 50;
  return '$randomNumber EGP';
}
String getRandomImageLink() {
  var random = Random();
  int randomNumber = random.nextInt(7) + 1;
  return 'assets/imgs/$randomNumber.png';
}



}

