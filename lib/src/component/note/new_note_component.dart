import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../firebase_service.dart';
import '../../model/note.dart';

@Component(
    selector: 'new-note',
    templateUrl: 'new_note_component.html',
    directives: const [CORE_DIRECTIVES, formDirectives])
class NewNoteComponent {
  final FirebaseService service;
  bool fileDisabled = false;
  Note note;

  @ViewChild("submit")
  ElementRef submitButton;

  NewNoteComponent(this.service) : this.note = new Note();

  uploadImage(e) async {
    fileDisabled = true;
    var file = (e.target as FileUploadInputElement).files[0];
    var image = await service.postItemImage(file);

    note.imageUrl = image.toString();
    fileDisabled = false;
  }

  removeImage() {
    service.removeItemImage(note.imageUrl);

    note.imageUrl = null;
    fileDisabled = false;
  }

  submitForm() {
    service.postItem(note);

    submitButton.nativeElement.blur();
    note = new Note();
  }
}
