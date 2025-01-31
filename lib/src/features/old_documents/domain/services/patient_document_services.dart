

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../core/api/api.dart';
import '../model/patient_document_model.dart';


final patientDocumentProvider = FutureProvider.family((ref,Tuple2<String,String> value) => PatientDocumentServices.getPatientDocuments(userCode: value.value1, token: value.value2));
final patientLocalDocumentProvider = StateProvider.family((ref,Tuple2<String,String> value) => PatientDocumentServices.getLocalDocuments(userCode: value.value1, token: value.value2));


/// Patient Documents...
const getPatientDocumentsUrl = '${Api.baseUrl}/PatientDocument/GetDocuList';
const addPatientDocumentsUrl = '${Api.baseUrl}/PatientDocument/InsertDocument/documentUrl';
const delPatientDocumentsUrl = '${Api.baseUrl}/PatientDocument/DeleteDocument';

class PatientDocumentServices{




  static Future<List<PatientDocumentModel>> getPatientDocuments({required String userCode,required String token}) async{

    try{
      final dio = Dio();
      // print(token);
      dio.options.headers['Authorization']='Bearer $token';

      final response = await dio.get('${getPatientDocuments}/$userCode');

      if(response.statusCode == 200){
        final data = response.data['result'] as List<dynamic>;
        final documents = data.map((e) => PatientDocumentModel.fromJson(e)).toList();

        return documents;

      }
      else{
        throw Exception('${response.statusCode} ${response.statusMessage ?? 'Something went wrong'}');
      }


    }on DioException catch(e){
      throw Exception('${e.response?.statusCode} ${e.response?.statusMessage ?? 'Something went wrong'}');
    }


  }


  static Future<Either<String,String>> addPatientDocuments({required Map<String, dynamic> data,required String token}) async{

    try{


      final dio = Dio();
      dio.options.headers['Authorization']='Bearer $token';

      final formData = FormData.fromMap(data);
      final response = await dio.post(addPatientDocumentsUrl,
        data: formData
      );

      if(response.statusCode == 200){
        return Right('Document Uploaded');

      }
      else{
        return Left('${response.statusCode} ${response.statusMessage ?? 'Something went wrong'}');
      }


    }on DioException catch(e){
      return Left('${e.response?.statusCode} ${e.response?.statusMessage ?? 'Something went wrong'}');
    }


  }


  static Future<Either<String,String>> delPatientDocument({required PatientDocumentModel file,required String token}) async{

    try{

      final dio = Dio();

     
      dio.options.headers['Authorization']='Bearer $token';

      final response = await dio.get('$delPatientDocumentsUrl/${file.documentID}');

      if(response.statusCode == 200 || response.statusCode == 500){

        return Right('Document Deleted');

      }
      else{
        return Left('${response.statusCode} ${response.statusMessage ?? 'Something went wrong'}');
      }


    }on DioException catch(e){
      if(e.response?.statusCode == 500){

        return Right('Document Deleted');

      }
      return Left('${e.response?.statusCode} ${e.response?.statusMessage ?? 'Something went wrong'}');
    }


  }


  static List<PatientDocumentModel> getLocalDocuments({required String userCode,required String token}) {

    try{


      final documentList = Hive.box<PatientDocumentModel>('patientDocs').values.where((element) => element.userID==userCode).toList();

      return documentList;


    }on DioException catch(e){
      throw Exception('${e.response?.statusCode} ${e.response?.statusMessage ?? 'Something went wrong'}');
    }


  }


  static Either<String,String> saveLocalDocuments({required PatientDocumentModel data,required String token}) {

    try{
      final docBox = Hive.box<PatientDocumentModel>('patientDocs');
      final docList = docBox.values.toList();


      if(docList.where((element) => element.documentID == data.documentID).firstOrNull == null){
        docBox.add(data);



        return Right('Document Downloaded');
      }
      else{
        return Right('Document already downloaded');
      }





    }on DioException catch(e){
      return Left('${e.response?.statusCode} ${e.response?.statusMessage ?? 'Something went wrong'}');
    }


  }


  static Either<String,String> delLocalDocument({required PatientDocumentModel file,required String token}) {

    try{

      final docBox = Hive.box<PatientDocumentModel>('patientDocs');

      final docList = docBox.values.toList();

      final delIndex = docList.indexWhere((element) => element.documentID == file.documentID);

      docBox.deleteAt(delIndex);

      File tempFile = File(file.attachmentsData!);

      tempFile.delete();

        return Right('Document Deleted');

    }on DioException catch(e){
      if(e.response?.statusCode == 500){

        return Right('Document Deleted');

      }
      return Left('${e.response?.statusCode} ${e.response?.statusMessage ?? 'Something went wrong'}');
    }


  }


}