class Usermodel{

   String? title;
   String? note;

   Usermodel({
     this.title,this.note
   });
    Usermodel fromJson(Map<String, dynamic> json, String id) => Usermodel(
       
        title: json['title'],
        note: json['note'],
       
      );
      Map<String, dynamic> toJson() => {
      
        'title': title,
        'note': note,
      };
      

}