class Note {
  String title;
  String text;
  String yt;
  String dalil;
  Note (this.title, this.text, this.yt, this.dalil);

  Note.fromJson(Map<String, dynamic> json){
    title = json['title'];
    text = json['text'];
    yt = json['yt'];
    dalil = json['dalil'];
  }
}
