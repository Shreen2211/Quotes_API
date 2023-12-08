import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/QuotesModel.dart';
import '../bloc/qoutes_cubit.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title:  Text('QUOTE',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.pink),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                onFieldSubmitted: (value) {
                  QoutesCubit.get(context).QuotesGet();
                },
                controller: QoutesCubit.get(context).SearchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pink,
                      ), borderRadius: BorderRadius.circular(12.0),
                    ),
                  enabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                    ), borderRadius: BorderRadius.circular(12.0),
                  )
                ),
              ),
            ),
            Expanded(
              child: BlocConsumer<QoutesCubit, QoutesState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  var cubit = QoutesCubit.get(context);
                  return cubit.quotes.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            Quote quoote = cubit.quotes[index];
                            return Container(
                              margin: const EdgeInsets.all(15),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0x2fec407a),
                                border: Border.all(
                                  color: Colors.pink,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\"${quoote.body ?? ''}\"',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          '\'${quoote.author ?? ''}\'',
                                          style: const TextStyle(
                                              fontSize: 18, color: Colors.pink),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(onPressed: (){
                                        if(cubit.quotes[index].isFav==false){
                                          cubit.PutFav(cubit.quotes[index].id??0);
                                          cubit.quotes[index].favoritesCount=(cubit.quotes[index].favoritesCount!+1);
                                        }else
                                          {
                                            cubit.PutunFav(cubit.quotes[index].id??0);
                                            cubit.quotes[index].favoritesCount=(cubit.quotes[index].favoritesCount!-1);
                                          }
                                      }, icon: cubit.quotes[index].icon ,color: cubit.quotes[index].color,),
                                      Text(quoote.favoritesCount.toString())
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: cubit.quotes.length,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
