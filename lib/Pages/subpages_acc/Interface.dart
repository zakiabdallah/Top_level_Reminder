import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Interface extends StatefulWidget {
  Interface({Key? key}) : super(key: key);

  @override
  State<Interface> createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
  bool isSwitched1 = false;
  List<String> fontsize = ["10"];
  void toggleSwitch1(bool value) {
    if (isSwitched1 == false) {
      setState(() {
        isSwitched1 = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched1 = false;
      });
      print('Switch Button is OFF');
    }
  }

  bool isSwitched2 = false;
  void toggleSwitch2(bool value) {
    if (isSwitched2 == false) {
      setState(() {
        isSwitched2 = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched2 = false;
      });
      print('Switch Button is OFF');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 11; i <= 30; i++) {
      fontsize.add(i.toString());
    }
  }

  List<String> fontFamily = [
    'Arial',
    'Abadi MT Condensed Light',
    'Albertus Extra Bold',
    'Albertus Medium',
    'Antique Olive',
    'Arial Black',
    'Arial MT',
    'Arial Narrow',
    'Bazooka',
    'Book Antiqua',
    'Bookman Old Style',
    'Boulder',
    'Calisto MT',
    'Calligrapher',
    'Century Gothic',
    'Century Schoolbook',
    'Cezanne',
    'CG Omega',
    'CG Times',
    'Charlesworth',
    'Chaucer',
    'Clarendon Condensed',
    'Comic Sans MS',
    'Copperplate Gothic Bold',
    'Copperplate Gothic Light',
    'Cornerstone',
    'Coronet',
    'Courier',
    'Courier New',
    'Cuckoo',
    'Dauphin',
    'Denmark',
    'Fransiscan',
    'Garamond',
    'Geneva',
    'Haettenschweiler',
    'Heather',
    'Helvetica',
    'Herald',
    'Impact',
    'Jester',
    'Letter Gothic',
    'Lithograph',
    'Lithograph Light',
    'Long Island',
    'Lucida Console',
    'Lucida Handwriting',
    'Lucida Sans',
    'Lucida Sans Unicode',
    'Marigold',
    'Market',
    'Matisse ITC',
    'MS LineDraw',
    'News GothicMT',
    'OCR A Extended',
    'Old Century',
    'Pegasus',
    'Pickwick',
    'Poster',
    'Pythagoras',
    'Sceptre',
    'Sherwood',
    'Signboard',
    'Socket',
    'Steamer',
    'Storybook',
    'Subway',
    'Tahoma',
    'Technical',
    'Teletype',
    'Tempus Sans ITC',
    'Times',
    'Times New Roman',
    'Times New Roman PS',
    'Trebuchet MS',
    'Tristan',
    'Tubular',
    'Unicorn',
    'Univers',
    'Univers Condensed',
    'Vagabond',
    'Verdana',
    'Westminster',
    'Allegro',
    'Amazone BT',
    'AmerType Md BT',
    'Arrus BT',
    'Aurora Cn BT',
    'AvantGarde Bk BT',
    'AvantGarde Md BT',
    'BankGothic Md BT',
    'Benguiat Bk BT',
    'BernhardFashion BT',
    'BernhardMod BT',
    'BinnerD',
    'Bremen Bd BT',
    'CaslonOpnface BT',
    'Charter Bd BT',
    'Charter BT',
    'ChelthmITC Bk BT',
    'CloisterBlack BT',
    'CopperplGoth Bd BT',
    'English 111 Vivace BT',
    'EngraversGothic BT',
    'Exotc350 Bd BT',
    'Freefrm721 Blk BT',
    'FrnkGothITC Bk BT',
    'Futura Bk BT',
    'Futura Lt BT',
    'Futura Md BT',
    'Futura ZBlk BT',
    'FuturaBlack BT',
    'Galliard BT',
    'Geometr231 BT',
    'Geometr231 Hv BT',
    'Geometr231 Lt BT',
    'GeoSlab 703 Lt BT',
    'GeoSlab 703 XBd BT',
    'GoudyHandtooled BT',
    'GoudyOLSt BT',
    'Humanst521 BT',
    'Humanst 521 Cn BT',
    'Humanst521 Lt BT',
    'Incised901 Bd BT',
    'Incised901 BT',
    'Incised901 Lt BT',
    'Informal011 BT',
    'Kabel Bk BT',
    'Kabel Ult BT',
    'Kaufmann Bd BT',
    'Kaufmann BT',
    'Korinna BT',
    'Lydian BT',
    'Monotype Corsiva',
    'NewsGoth BT',
    'Onyx BT',
    'OzHandicraft BT',
    'PosterBodoni BT',
    'PTBarnum BT',
    'Ribbon131 Bd BT',
    'Serifa BT',
    'Serifa Th BT',
    'ShelleyVolante BT',
    'Souvenir Lt BT',
    'Staccato222 BT',
    'Swis721 BlkEx BT',
    'Swiss911 XCm BT',
    'TypoUpright BT',
    'ZapfEllipt BT',
    'ZapfHumnst BT',
    'ZapfHumnst Dm BT',
    'Zurich BlkEx BT',
    'Zurich Ex BT',
  ];
  String dropdownValue1 = 'English';
  String dropdownValue2 = 'Arial';
  String dropdownValue3 = '10';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interface'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text(
                "\t Languge ",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              DropdownButton<String>(
                  value: dropdownValue1,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue1 = newValue!;
                    });
                  },
                  items: <String>['English', 'Franch', 'Arabe']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList())
            ],
          ),
          Row(
            children: [
              Text(
                "\t FontSize ",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              DropdownButton<String>(
                  value: dropdownValue3,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue3 = newValue!;
                    });
                  },
                  items: fontsize.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList())
            ],
          ),
          Row(
            children: [
              Text(
                "\t FontFamily ",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              DropdownButton<String>(
                  value: dropdownValue2,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue2 = newValue!;
                    });
                  },
                  items:
                      fontFamily.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList())
            ],
          ),
        ],
      ),
    );
  }
}
