import 'package:barbershops_booking/blocs/GetDataBloc/Getonedatabloc.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_Event.dart';
import 'package:barbershops_booking/blocs/GetDataBloc/getdata_bloc.dart';
import 'package:barbershops_booking/widget/berSearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  GetOneDataBluc? bloc;


  @override
  void initState() {
  bloc = BlocProvider.of(context);
    super.initState();
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                    Expanded(
                    child: TextField(
                      controller: myController,
                    //  controller: myController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Search',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: IconButton(
                        onPressed: () {

                        bloc!.add(SarchEvetn(myController.text));
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.amber,
                        )),
                  )
                ],
              ),
            ),
            Expanded(
              child: berSearch()
            )
          ],
        ),
      )),
    );
  }
}
