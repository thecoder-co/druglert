import 'package:drug_alert_frontend/core/route/app_routes.dart';
import 'package:drug_alert_frontend/core/utils/extensions/widget_extensions.dart';
import 'package:drug_alert_frontend/features/home/models/user_model.dart';
import 'package:drug_alert_frontend/features/home/presentation/pages/create_new_drug.dart';
import 'package:drug_alert_frontend/features/home/providers/drug_provider.dart';
import 'package:drug_alert_frontend/features/home/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final drugs = ref.watch(drugProvider.notifier);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.blueGrey[100],
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pushTo(context, const CreateNewDrug());
          },
          backgroundColor: Colors.purple[900],
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MediaQuery.of(context).padding.top.spacingH,
                20.spacingH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        user.when(
                          data: (user) {
                            return Text(
                              'Hello, ${user.body!.email!.split('@').first}',
                              style: GoogleFonts.kanit(
                                fontSize: 22,
                                color: Colors.grey[900],
                              ),
                            );
                          },
                          error: (error, s) {
                            return Text(
                              'Hello, ',
                              style: GoogleFonts.kanit(
                                fontSize: 22,
                                color: Colors.grey[900],
                              ),
                            );
                          },
                          loading: () => Text(
                            'Hello, ',
                            style: GoogleFonts.kanit(
                              fontSize: 22,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        10.spacingH,
                        Text(
                          'How are you doing today?',
                          style: GoogleFonts.kanit(
                            fontSize: 12,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/medicine.png',
                      height: 80,
                    ),
                  ],
                ),
                20.spacingH,
                Text(
                  'Your medicines for today',
                  style: GoogleFonts.kanit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
                user.when(
                  data: (data) {
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: data.body!.drugs!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return 20.spacingH;
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return DrugListItem(
                          drug: data.body!.drugs![index],
                          isEven: index.isEven,
                          onPressed: () {
                            drugs.deleteDrug(
                              context,
                              id: data.body!.drugs![index].id!,
                            );
                          },
                        );
                      },
                    );
                  },
                  error: (e, x) => const SizedBox(),
                  loading: () => const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrugListItem extends StatelessWidget {
  final Drug drug;
  final bool isEven;
  final Function() onPressed;
  const DrugListItem({
    super.key,
    required this.drug,
    required this.isEven,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('yyyy-MM-dd').parse(drug.expiryDate!);
    final now = DateTime.now();
    // check if the date is expired
    final isExpired = date.isBefore(now);
    final nameDetails = drug.drugName!.split('\$');
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: isExpired
              ? [
                  Colors.red[900]!,
                  Colors.red[900]!,
                ]
              : isEven
                  ? [Colors.purple[900]!, Colors.purple]
                  : [Colors.red[300]!, Colors.red[100]!],
          radius: 50,
        ),
        color: isEven ? Colors.purple[900] : Colors.red[300],
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Image.asset(
            'assets/pills (1).png',
            height: 50,
          ),
          10.spacingW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  nameDetails.first,
                  style: GoogleFonts.kanit(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    if (nameDetails.length > 1)
                      Expanded(
                        child: Text(
                          nameDetails.last,
                          style: GoogleFonts.kanit(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: Text(
                          'Batch: ...',
                          style: GoogleFonts.kanit(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    Text(
                      '${drug.expiryDate}',
                      style: GoogleFonts.kanit(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
