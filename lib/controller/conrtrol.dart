import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:googleclone/screen/Homepage.dart';

class google extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getuserdeatails();


  }
  List items=[];

  getuserdeatails()async{
   

    try{

      var result= await FirebaseFirestore.instance
                .collection('data').get().then((querySnapshot){
                  querySnapshot.docs.forEach((element) {
                    
                   items.add(element.data());
                    print(element.data());
                  });
                  update();



                });
                return;
          
    }catch (e) {
      print(e.toString());

    }
    update();

  }




}


