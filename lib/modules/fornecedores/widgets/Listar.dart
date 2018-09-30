import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Listar extends StatefulWidget {

    Listar({Key key}) : super(key: key);

    @override
    _ListarState createState() => new _ListarState();
}

class _ListarState extends State<Listar> {
  
    bool longPressFlag = false;
  
    List<Element> indexList = new List();

    onElementSelected(int index){

        setState((){
            
            indexList[index].isSelected = !indexList[index].isSelected;
        });
    }
  
    void longPress() {
        
        setState(() {

            longPressFlag = !indexList.isEmpty;
        });
    }

    @override
    Widget build(BuildContext context) {

        for(var i=0;i<15;i++){
            indexList.add(Element(isSelected: false));
        }

        return new Scaffold(
            
            appBar: new AppBar(
                title: new Text('Selected ${indexList.length}  ' + indexList.toString()),
            ),
            
            body: new ListView.builder(
                
                itemCount: 15,
                itemBuilder: (context, index) {
                
                    return new CustomWidget(
                    
                        index: index,
                        isSelected: indexList[index].isSelected,
                        longPressEnabled: longPressFlag,

                        callback: () {
                            
                            onElementSelected(index);
                            
                            if (indexList.contains(index)) {
                                
                                indexList.remove(index);
                            }
                            else {
                                
                                indexList.add(Element());
                            }

                            longPress();
                        },
                    );
                },
            )
        );
  }
}

class CustomWidget extends StatefulWidget {
    final int index;
    final bool longPressEnabled;
    final VoidCallback callback;
    final bool isSelected;

    const CustomWidget({Key key, this.index, this.longPressEnabled, this.callback,this.isSelected}) : super(key: key);

    @override
    _CustomWidgetState createState() => new _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
    
    bool selected = false;

    @override
    Widget build(BuildContext context) {

        return new GestureDetector(
            onLongPress: () {
            
                widget.callback();
            },
            
            onTap: () {
            
                if (widget.longPressEnabled) {
                    widget.callback();
                }
            },
            
            child: new Container(
                
                margin: new EdgeInsets.all(5.0),
                
                child: new ListTile(
                    title    : new Text("Title ${widget.index}"),
                    subtitle : new Text("Description ${widget.index}"),
                ),
                
                decoration: widget.isSelected ? 
                    new BoxDecoration(color: Colors.black38, border: new Border.all(color: Colors.black)) : new BoxDecoration(),
            ),
        );
    }
}

class Element{
    
    bool isSelected;
    
    Element({this.isSelected});
}