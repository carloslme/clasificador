import 'package:flutter/material.dart';


class ViewGrid extends StatefulWidget{
  final String title = "Texto";
  @override
  State<StatefulWidget> createState(){
    return _GridImages();
  }
}

class _GridImages extends State<ViewGrid> {
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  HeaderWidget("Header 1"),
                  HeaderWidget("Header 2"),
                  HeaderWidget("Header 3"),
                  HeaderWidget("Header 4"),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BodyWidget(Colors.blue),
                  BodyWidget(Colors.red),
                  BodyWidget(Colors.green),
                  BodyWidget(Colors.orange),
                  BodyWidget(Colors.blue),
                  BodyWidget(Colors.red),
                ],
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              delegate: SliverChildListDelegate(
                [
                  BodyWidget(Colors.blue),
                  BodyWidget(Colors.green),
                  BodyWidget(Colors.yellow),
                  BodyWidget(Colors.orange),
                  BodyWidget(Colors.blue),
                  BodyWidget(Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
//    @override
//    List<Widget> _buildGridTiles(numberOfTiles) {
//      List<Container> containers = new List<Container>.generate(numberOfTiles,
//              (int index) {
//            //index = 0, 1, 2,...
//            final imageName = index < 3 ?
//            'data/img/image0${index + 1}.jpg' : 'data/img/image${index +
//                1}.jpg';
//            return new Container(
//              child: new Image.asset(
//                  imageName,
//                  fit: BoxFit.fill
//              ),
//            );
//          });
//      return containers;
//    }
//
//    return new GridView.extent(
//      maxCrossAxisExtent: 150.0,
//      mainAxisSpacing: 5.0,
//      crossAxisSpacing: 5.0,
//      padding: const EdgeInsets.all(5.0),
//      children: _buildGridTiles(5),
//    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String text;

  HeaderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(text),
      color: Colors.grey[200],
    );
  }
}

class BodyWidget extends StatelessWidget {
  final Color color;

  BodyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: color,
      alignment: Alignment.center,

    );
  }
}

