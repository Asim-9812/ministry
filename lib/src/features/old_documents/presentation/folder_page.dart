


import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/features/status_page/domain/model/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/api/api.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/gap_manager.dart';
import '../../old_reminder/utils/old_common_utils.dart';
import '../controller/document_provider.dart';
import '../controller/pdf_api.dart';
import '../domain/model/patient_document_model.dart';
import '../domain/services/patient_document_services.dart';
import 'widgets/pdf_viewer.dart';



class PatientFolderPage extends ConsumerWidget {
  final String title;
  PatientFolderPage({required this.title});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context,ref) {

    final user = Hive.box<UserModel>('users').values.first;
    final allDocuments = ref.watch(patientDocumentProvider(Tuple2(user.userName!, user.token!)));
    final documentTypeId = ref.watch(commonProvider).selectedDocumentType;

    final searchEnabled = ref.watch(commonProvider).documentSearch;
    final query = ref.watch(commonProvider).filteredText.toLowerCase();


    return PopScope(
      canPop: true,
      onPopInvoked: (value){
        ref.read(commonProvider.notifier).updateDocumentTypeId(0);
        ref.read(commonProvider.notifier).searchDocument('');
        ref.read(commonProvider.notifier).enableDocumentSearch(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title,style: wh3,),
          leading: IconButton(onPressed: (){
            ref.read(commonProvider.notifier).updateDocumentTypeId(0);
            ref.read(commonProvider.notifier).searchDocument('');
            ref.read(commonProvider.notifier).enableDocumentSearch(false);
            Navigator.pop(context);
          },icon: Icon(Icons.chevron_left,color: MyColors.secondary,),),
          actions: [
            if(!searchEnabled)
              IconButton(onPressed: (){
                ref.read(commonProvider.notifier).enableDocumentSearch(true);
                ref.read(commonProvider.notifier).searchDocument('');
                _searchController.clear();

              }, icon: Icon(Icons.search,color: MyColors.secondary,))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: MyColors.secondary,
          onPressed: ()=>_showBottomMenu(context, ref),
          child: Icon(Icons.drive_folder_upload,color: MyColors.white,),
        ),
        body: allDocuments.when(
            data: (data){
              if(data.isEmpty){
                  return RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    displacement: 20,
                    // strokeWidth: 20,
                    onRefresh: () async {
                      //print('refreshing');
                      ref.refresh(patientDocumentProvider(Tuple2(user.userName!, user.token!)));
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Image.asset('assets/images/errors/empty.jpg',filterQuality: FilterQuality.low,),
                          h10,
                          Text('NO FILES',textAlign: TextAlign.center,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                  );
                }
              final files = documentTypeId == 1
                  ? data.where((element) => element.documentTypeID == 1).toList()
                  : documentTypeId == 2 ? data.where((element) => element.documentTypeID == 2).toList()
                  : data;

              final filteredFiles = files.where((element) => element.documentTitle.toLowerCase().contains(query)||element.folderName.toLowerCase().contains(query) ||element.completedDate.toString().toLowerCase().contains(query)).toList();

              bool haveImage = data.any((element) => element.documentTypeID == 2);
              bool havePdf = data.any((element) => element.documentTypeID == 1);
              return Padding(
                padding: allPadding,
                child: RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  displacement: 20,
                  // strokeWidth: 20,
                  onRefresh: () async {
                    //print('refreshing');
                    ref.refresh(patientDocumentProvider(Tuple2(user.userName!, user.token!)));
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Stack(
                      children: [
                        Visibility(
                          visible: searchEnabled,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: MyColors.grey,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  hintText: 'Search',
                                    suffixIcon: IconButton(onPressed: (){
                                      ref.read(commonProvider.notifier).searchDocument('');
                                      ref.read(commonProvider.notifier).enableDocumentSearch(false);
                                      _searchController.clear();
                                    }, icon: Icon(Icons.close,color: MyColors.secondary,))
                                ),
                                onChanged: (value){
                                  ref.read(commonProvider.notifier).searchDocument(value);
                                },
                              ),

                              h30,
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.grey.withOpacity(0.6)
                                ),
                                padding: allPadding,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Files',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: MyColors.darkGrey),),
                                    h10,
                                    ListView.builder(
                                      // padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: filteredFiles.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        IconData icon = filteredFiles[index].documentTypeID == 1? Icons.picture_as_pdf : Icons.image ;
                                        final date = DateFormat('yyyy-MM-dd').format(filteredFiles[index].completedDate);
                                        return Column(
                                          children: [
                                            Divider(
                                              height: 0,
                                              color: MyColors.darkGrey,
                                              thickness: 0.2,
                                            ),
                                            ListTile(
                                              onTap: () async {
                                                if(filteredFiles[index].documentTypeID == 2){
                                                  final image = Image.network('${Api.baseUrl}/${filteredFiles[index].patientAttachment}').image;
                                                  showImageViewer(context, image, onViewerDismissed: () {
                                                  });
                                                }
                                                else{
                                                  final String path = '${Api.baseUrl}/${filteredFiles[index].patientAttachment}';
                                                  final file = await PDFApi.loadNetwork(path);
                                                  Navigator.push(context, routeTo(context, PDFViewerPage(file: file,title:filteredFiles[index].documentTitle)));

                                                }
                                              },
                                              contentPadding: EdgeInsets.zero,
                                              leading: Icon(icon,color: MyColors.primary,size: 30,),
                                              title: Text(filteredFiles[index].documentTitle),
                                              subtitle: Text(date,style: TextStyle(color: MyColors.darkGrey,fontSize: 10)),
                                              trailing: IconButton(
                                                  onPressed: (){
                                                    _fileMenu(context, ref, filteredFiles[index]);
                                                  }, icon: Icon(Icons.more_vert,color: MyColors.black,size: 18,)),
                                            ),

                                          ],
                                        );
                                      },

                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: !searchEnabled,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Quick Access',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: MyColors.darkGrey),),
                              h10,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      ref.read(commonProvider.notifier).updateDocumentTypeId(0);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: documentTypeId == 0 ? MyColors.primary : MyColors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: MyColors.darkGrey,
                                              width: 0.5
                                          )
                                      ),
                                      padding: allPadding,
                                      child: Center(
                                        child: Icon(Icons.all_inclusive,color: documentTypeId == 0 ? MyColors.white : MyColors.primary,size: 40,),
                                      ),
                                    ),
                                  ),
                                  w10,
                                  if(havePdf)
                                    InkWell(
                                      onTap: (){
                                        ref.read(commonProvider.notifier).updateDocumentTypeId(1);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: documentTypeId == 1 ? MyColors.primary : MyColors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: MyColors.darkGrey,
                                                width: 0.5
                                            )
                                        ),
                                        padding: allPadding,
                                        child: Center(
                                          child: Icon(Icons.picture_as_pdf,color: documentTypeId == 1 ? MyColors.white : MyColors.primary,size: 40,),
                                        ),
                                      ),
                                    ),
                                  if(havePdf)
                                    w10,
                                  if(haveImage)
                                    InkWell(
                                      onTap: (){
                                        ref.read(commonProvider.notifier).updateDocumentTypeId(2);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: documentTypeId == 2 ? MyColors.primary : MyColors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: MyColors.darkGrey,
                                                width: 0.5
                                            )
                                        ),
                                        padding: allPadding,
                                        child: Center(
                                          child: Icon(Icons.image,color: documentTypeId == 2 ? MyColors.white : MyColors.primary,size: 40,),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              h30,
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.grey.withOpacity(0.6)
                                ),
                                padding: allPadding,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Files',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: MyColors.darkGrey),),
                                    h10,
                                    ListView.builder(
                                      // padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: files.length > 5 ? 5 : files.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        IconData icon = files[index].documentTypeID == 1? Icons.picture_as_pdf : Icons.image ;
                                        final date = DateFormat('yyyy-MM-dd').format(files[index].completedDate);
                                        return Column(
                                          children: [
                                            Divider(
                                              height: 0,
                                              color: MyColors.darkGrey,
                                              thickness: 0.2,
                                            ),
                                            ListTile(
                                              onTap: () async {
                                                if(files[index].documentTypeID == 2){
                                                  final image = Image.network('${Api.baseUrl}/${files[index].patientAttachment}').image;
                                                  showImageViewer(context, image, onViewerDismissed: () {
                                                  });
                                                }
                                                else{
                                                  final String path = '${Api.baseUrl}/${files[index].patientAttachment}';
                                                  final file = await PDFApi.loadNetwork(path);
                                                  Navigator.push(context, routeTo(context, PDFViewerPage(file: file,title:files[index].documentTitle)));

                                                }
                                              },
                                              contentPadding: EdgeInsets.zero,
                                              leading: Icon(icon,color: MyColors.primary,size: 30,),
                                              title: Text(files[index].documentTitle),
                                              subtitle: Text(date,style: TextStyle(color: MyColors.darkGrey,fontSize: 10)),
                                              trailing: IconButton(
                                                  onPressed: (){
                                                    _fileMenu(context, ref, files[index]);
                                                  }, icon: Icon(Icons.more_vert,color: MyColors.black,size: 18,)),
                                            ),

                                          ],
                                        );
                                      },

                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )


                      ],
                    ),
                  ),
                ),
              );

            },
            error: (error,stack) => Center(child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/errors/error.jpg',filterQuality: FilterQuality.low,),
                  h10,
                  Text('Please try again later. \n ${error}',textAlign: TextAlign.center,)
                ],
              ),
            ),),
            loading: (){
              return Padding(
                padding: horizontalPadding,
                child: SingleChildScrollView(
                  child: loadingShimmer(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                        h20,
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            w10,
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        h20,
                        ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          title: Container(
                            height: 20,
                            width: double.infinity,
                          ),
                          subtitle: Container(
                            height: 10,
                            width: 250,
                          ),
                        ),
                        h06,
                        ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          title: Container(
                            height: 20,
                            width: double.infinity,
                          ),
                          subtitle: Container(
                            height: 10,
                            width: 250,
                          ),
                        ),
                        h06,
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }

  void _showBottomMenu(BuildContext context,ref) async {

    await showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            // height: 500,
            padding: allPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                h30,
                Text('Please select a type of document to upload'),
                h10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context);
                        ref.read(commonProvider.notifier).updateDocumentType(2);
                        Navigator.pushNamed(context, '/patientAddDocuments');
                      },
                      child: Container(
                        padding: allPadding,
                        decoration: BoxDecoration(
                            color: MyColors.grey,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: MyColors.secondary,
                                width: 0.5
                            )
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.image,size: 40,),
                            h10,
                            Text('Image')
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context);
                        ref.read(commonProvider.notifier).updateDocumentType(1);
                        Navigator.pushNamed(context, '/patientAddDocuments');
                      },
                      child: Container(
                        padding: allPadding,
                        decoration: BoxDecoration(
                            color: MyColors.grey,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: MyColors.secondary,
                                width: 0.5
                            )
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.picture_as_pdf,size: 40,),
                            h10,
                            Text('PDF')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                h30
              ],
            ),

          );
        }
    );

  }

  void _fileMenu(BuildContext context,ref, PatientDocumentModel file) async {
    final icon = file.documentTypeID == 1 ? Icons.picture_as_pdf : Icons.image;
    final fileLink = '${Api.baseUrl}/${file.patientAttachment}';

    var link = fileLink.replaceAll('\\', '/');
    await showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            padding: allPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h10,
                ListTile(
                  onTap: () async {
                    if(file.documentTypeID == 2){
                      final image = Image.network('${Api.baseUrl}/${file.patientAttachment}').image;
                      showImageViewer(context, image, onViewerDismissed: () {

                      });
                    }
                    else{
                      final String path = '${Api.baseUrl}/${file.patientAttachment}';
                      final pdfFile = await PDFApi.loadNetwork(path);
                      Navigator.push(context, routeTo(context, PDFViewerPage(file: pdfFile,title:file.documentTitle)));

                    }
                  },
                  leading: Icon(icon),
                  title: Text(file.documentTitle,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                ),
                h10,
                Divider(),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    _fileDetail(context, ref, file);
                  },
                  leading: Icon(Icons.info),
                  title: Text('Details'),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    Navigator.pop(context);
                    await ShareExternal.share(link: link);
                  },
                  leading: Icon(Icons.share),
                  title: Text('Share'),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    Navigator.pop(context);
                    Toaster.success('Downloading...');
                    _saveFile(context, ref, file);
                  },
                  leading: Icon(Icons.download),
                  title: Text('Download'),
                ),
                Divider(),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    _delFile(context, ref, file);
                  },
                  leading: Icon(Icons.delete_forever_rounded),
                  title: Text('Delete'),
                ),
                h50
              ],
            ),
          );
        });
  }

  void _fileDetail(BuildContext context,ref, PatientDocumentModel file) async {
    final dio = Dio();
    final icon = file.documentTypeID == 1 ? Icons.picture_as_pdf : Icons.image;
    final date = DateFormat('yyyy-MM-dd').format(file.completedDate);
    final fileLink = '${Api.baseUrl}/${file.patientAttachment}';
    final data = await dio.get(fileLink);
    final size = (double.parse(data.headers['content-length']!.toList().first)  * 0.001).toStringAsFixed(1);

    await showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            padding: allPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h10,
                ListTile(
                  onTap: () async {
                    if(file.documentTypeID == 2){
                      final image = Image.network('${Api.baseUrl}/${file.patientAttachment}').image;
                      showImageViewer(context, image, onViewerDismissed: () {

                      });
                    }
                    else{
                      final String path = '${Api.baseUrl}/${file.patientAttachment}';
                      final pdfFile = await PDFApi.loadNetwork(path);
                      Navigator.push(context, routeTo(context, PDFViewerPage(file: pdfFile,title:file.documentTitle)));

                    }
                  },
                  leading: Icon(icon),
                  title: Text(file.documentTitle,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                  subtitle: Text('$size KB'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.calendar_month),
                  title: Text('Completed Date',style: TextStyle(fontSize: 12),),
                  subtitle: Text(date),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.description),
                  title: Text('Description',style: TextStyle(fontSize: 12),),
                  subtitle: Text(file.documentDescription),
                ),
                h50
              ],
            ),
          );
        });
  }

  void _delFile(context,ref,PatientDocumentModel file) async{
    final user = Hive.box<UserModel>('users').values.first;
    await showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('${file.documentTitle} will be deleted forever.'),
        actions: [
          regularTextButton(text: 'Cancel', onPressed: ()=>Navigator.pop(context)),
          regularTextButton(text: 'Delete', onPressed: (){
            ref.read(patientDocumentNotifier.notifier).delFile(file).then((value){
              ref.refresh(patientDocumentProvider(Tuple2(user.userName!, user.token!)));
              Navigator.pop(context);
            });
          })
        ],
      );
    });

  }

  void _saveFile(context,ref,PatientDocumentModel file) async{
    final user = Hive.box<UserModel>('users').values.first;
    File? tempFile = await getFile(file.patientAttachment);

    if(tempFile != null){

      PatientDocumentModel data = PatientDocumentModel(
          documentID: file.documentID, userID: file.userID,
          code: file.code, documentTypeID: file.documentTypeID, folderName: file.folderName,
          patientAttachmentID: file.patientAttachmentID,
          patientAttachment: file.patientAttachment,
          documentTitle: file.documentTitle, documentDescription: file.documentDescription,
          duration: file.duration, durationType: file.durationType,
          completedDate: file.completedDate,
          attachmentsData: tempFile.path
      );

      ref.read(patientDocumentNotifier.notifier).saveDocument(
          context:context,
          token: 'token',
          data:data
      );

      ref.refresh(patientLocalDocumentProvider(Tuple2(user.userName!, user.token!)));

    }
    else{
      Toaster.error('Download Failed');
    }

  }

  Future<File?> getFile(String? newFile) async {
    if (newFile != null) {
      String filePath = newFile.replaceAll('\\', '/');
      try {
        final response = await http.get(Uri.parse('${Api.baseUrl}/$filePath'));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final base = basename(filePath);
          final appDocDir = await getExternalStorageDirectory();
          final imagePath = '${appDocDir?.path}/$base';
          final file = File(imagePath);
          await file.writeAsBytes(bytes);
          return file;
        } else {
          return null;
        }
      } catch (e) {
        print('Error fetching image from API: $e');
        return null;
      }
    } else {
      // Handle case where filePath is null
      return null;
    }
  }

}
