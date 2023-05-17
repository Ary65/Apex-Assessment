import 'dart:convert';
import 'package:apex_assessment/model/get_comapny_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final currentPageProvider = StateProvider.autoDispose<int>((ref) => 1);

final apiServiceProvider = Provider.autoDispose<ApiService>((ref) => ApiService());

final companiesProvider =
    FutureProvider.autoDispose<GetCompanyModel>((ref) async {
  try {
    final currentPage = ref.watch(currentPageProvider.notifier).state;
    final url =
        'http://139.59.35.127/apex-dmit/public/api/company?page=$currentPage';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final getCompanyModel = GetCompanyModel.fromJson(jsonResponse);
      return getCompanyModel;
    } else {
      throw Exception(
          'Failed to fetch companies. Status code: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('An error occurred while fetching companies: $error');
  }
});

class ApiService {
  Future<void> createNewCompany(
    String companyName,
    String workEmail,
    String password,
    String phone,
  ) async {
    const url =
        'http://139.59.35.127/apex-dmit/public/api/company';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'company_name': companyName,
          'email': workEmail,
          'password': password,
          'phone': phone,
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // Request successful, handle the response data here
        debugPrint('Company created successfully');
        debugPrint(result);
      } else {
        // Request failed, handle the error here
        debugPrint('Failed to create company');
        debugPrint('Error status code: ${response.statusCode}');
        debugPrint('Error response body: ${response.body}');
      }
    } catch (error) {
      // Exception occurred during the request, handle the error here
      debugPrint('An exception occurred in creating company: $error');
    }
  }
}
