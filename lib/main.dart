import 'package:app/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'api.dart';

// import 'package:provi';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryController(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ViewCategory()),
    );
  }
}

class ViewCategory extends StatefulWidget {
  const ViewCategory({Key? key}) : super(key: key);

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryController>(context, listen: false).get();
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .02,
                bottom: MediaQuery.of(context).size.width * .02),
            child: Consumer<CategoryController>(builder: (context, cont, _) {
              if (cont.loading != true) {
                return Wrap(
                    children: List.generate(cont.listCategory.length, (index) {
                  cont.openCart(index);
                  return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      switchInCurve: Curves.easeInOutBack,
                      transitionBuilder: (child, animation) => ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                      child: cont.open[index] == true
                          ? cartd(context, index, const ValueKey('lock'),
                              cont.listCategory[index])
                          : Container(
                              key: const ValueKey('unlock'),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * .1),
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * .02,
                                  top: MediaQuery.of(context).size.width * .02),
                              height: MediaQuery.of(context).size.width * .7,
                              width: MediaQuery.of(context).size.width * .47,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(255, 245, 245, 245),
                              ),
                            ));

                  // return cartd(context, index);
                }));
              } else {
                return Wrap(
                  children: List.generate(
                      6,
                      (index) => Container(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * .015),
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * .02,
                                top: MediaQuery.of(context).size.width * .02),
                            height: MediaQuery.of(context).size.width * .7,
                            width: MediaQuery.of(context).size.width * .47,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 245, 245, 245),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Color.fromARGB(255, 238, 238, 238),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.width * .6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromARGB(255, 238, 238, 238),

                                      // color: Colors.amber,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Shimmer.fromColors(
                                    baseColor:
                                        Color.fromARGB(255, 238, 238, 238),
                                    highlightColor: Colors.white,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .05,
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      color: Color.fromARGB(255, 238, 238, 238),
                                    ))
                              ],
                            ),
                          )),
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget cartd(BuildContext context, int index, key, ModelCategory model) {
    return Container(
      key: key,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * .015),
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * .02,
        bottom: MediaQuery.of(context).size.width * .02,
      ),
      height: MediaQuery.of(context).size.width * .7,
      width: MediaQuery.of(context).size.width * .47,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 3),
            color: Colors.blue.withOpacity(.1))
      ], borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width * .6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(
                      color:
                          const Color.fromARGB(255, 19, 54, 83).withOpacity(.3),
                      width: .5),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(model.image))
                  // color: Colors.amber,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(model.mainCategoryProductName,
                  style: GoogleFonts.nunitoSans()),
            )
          ],
        ),
      ),
    );
  }
}
