import Foundation
import SwiftUI
import MobileCoreServices

struct FilePickerController: UIViewControllerRepresentable {
   
    @Binding var urlaudio:URL
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPick = UIDocumentPickerViewController(documentTypes: ["com.microsoft.waveform-audio","public.mp3"], in: UIDocumentPickerMode.open)
        documentPick.delegate = context.coordinator
         documentPick.allowsMultipleSelection = false
        return documentPick
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<FilePickerController>) {
        
    }
    


    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: FilePickerController

        init(_ pickerController: FilePickerController) {
            self.parent = pickerController

        }

         func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {


              guard let selectfileurl = urls.first else {
                  return
                
            }
            parent.urlaudio = selectfileurl
    
          
            
            

        }


    }
}
