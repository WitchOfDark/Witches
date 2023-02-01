import 'package:flutter/material.dart';

void main() => runApp(VegSliver());

class VegSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurryFormScreen(),
    );
  }
}

class CurryFormScreen extends StatefulWidget {
  @override
  _CurryFormScreenState createState() => _CurryFormScreenState();
}

class _CurryFormScreenState extends State<CurryFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _nameList = [
    'test',
    'test',
    'test',
    'test',
    'test',
    'test',
    'test',
    'test',
    'test',
    'test',
    'test',
    'test',
    'test'
  ];

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String? value) {
        if (value?.isEmpty ?? false) {
          return 'Name is required';
        }

        return null;
      },
      onSaved: (String? value) {
        setState(() {
          _nameList.add(value ?? '');
        });
      },
    );
  }

  Widget _buildListWidget(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 48),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    print(_nameList.toString());

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //
          SliverAppBar(
            title: Text('Cheetah Coding'),
            pinned: true,
            expandedHeight: 200,
            leading: Image.network(
              'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-1.2.1&auto=format&fit=crop&w=1866&q=80',
              fit: BoxFit.cover,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-1.2.1&auto=format&fit=crop&w=1866&q=80',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),

          //
          CurrySliverHeader(Colors.green, "Sticky Header 1"),
          CurrySliverHeader(Colors.red, "Sticky Header 2"),

          //
          SliverFixedExtentList(
            itemExtent: 100,
            delegate: SliverChildListDelegate([
              _buildListWidget(Colors.purple, "Curry"),
              _buildListWidget(Colors.blue, "Rice"),
              _buildListWidget(Colors.purple, "Pizza"),
              _buildListWidget(Colors.blue, "Hamburger"),
              _buildListWidget(Colors.purple, "Noodles"),
              _buildListWidget(Colors.blue, "Eggs"),
              _buildListWidget(Colors.purple, "Salad"),
            ]),
          ),

          //
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Add Name', style: TextStyle(fontSize: 22)),
                      _buildNameField(),
                      SizedBox(height: 16),
                      ElevatedButton(
                        child: Text('Submit'),
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),

          //
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(10),
                color: Colors.deepPurple,
                child: Center(
                  child: Text(
                    _nameList[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              );
            }, childCount: _nameList.length),
          )

          //
        ],
      ),
    );
  }
}

class CurrySliverHeader extends StatelessWidget {
  final Color backgroundColor;
  final String headerTitle;

  CurrySliverHeader(this.backgroundColor, this.headerTitle);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: Delegate(backgroundColor, headerTitle),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final String headerTitle;

  Delegate(this.backgroundColor, this.headerTitle);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Text(
          headerTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
