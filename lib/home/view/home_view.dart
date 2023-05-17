import 'package:apex_assessment/home/widgets/my_alert_dialog.dart';
import 'package:apex_assessment/providers/data_providers.dart';
import 'package:apex_assessment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  void showMyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MyDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final companiesAsyncValue = ref.watch(companiesProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Company List',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: companiesAsyncValue.when(
          data: (getCompanyModel) {
            final companies = getCompanyModel.companyList?.data;
            if (companies != null && companies.isNotEmpty) {
              return ListView.builder(
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        company.companyName ?? '',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(company.email ?? ''),
                          Text(company.phone ?? ''),
                        ],
                      ),
                      // Display other company details as needed
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No companies found'));
            }
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              const Center(child: Text('Error fetching companies')),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: () {
              final currentPage = ref.read(currentPageProvider.notifier).state;
              final newPage = currentPage + 1;
              ref.read(currentPageProvider.notifier).state = newPage;
              ref.refresh(companiesProvider.future).then((value) {});
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                )),
            child: const Text(
              'Show Next Page Data',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () => showMyDialog(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
