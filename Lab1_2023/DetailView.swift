//
//  ContentView.swift
//  Lab1_2023
//
//  Created by ICS 224 on 2023-01-11.
//

import SwiftUI
import Photos
struct DetailView: View {
    var colour: Color
    var charLimit: Int
    @State var pickerVisible = false
    @State var showCameraAlert = false
    @State var showLibraryAlert = false
    @State var imageSource = UIImagePickerController.SourceType.camera
    @Binding var inventoryItem: InventoryItem
    var body: some View {
        //        let defaultColor = Color.white
        
        ZStack {
            VStack {
                Image(uiImage: inventoryItem.image)
                    .resizable(resizingMode: .stretch)
                    .imageScale(.medium)
                    .scaledToFit()
                    .foregroundColor(.purple) //originally .accentColor
                    .border(inventoryItem.fave ? colour : Color.white)
                    .accessibilityIdentifier("DetailImage")
                    .gesture(TapGesture(count: 1).onEnded({
                    value in
                    PHPhotoLibrary.requestAuthorization({ status in
                        if status == .authorized {
                            self.showLibraryAlert = false
                            self.imageSource = UIImagePickerController.SourceType.photoLibrary
                            self.pickerVisible.toggle()
                        } else {
                            self.showLibraryAlert = true
                        }
                    })
                }))
                Toggle(isOn: $inventoryItem.fave) {
                    Text("Favourite")
                }
                .accessibilityIdentifier("FavouriteToggle")
                TextEditor(text: Binding(
                    get: {
                        inventoryItem.description
                    },
                    set: {
                        newValue in
                        if newValue.count <= charLimit {
                            inventoryItem.description = newValue
                        }
                    }
                )
                )
                .accessibilityIdentifier("DetailTextEditor")
                Text(String("\(inventoryItem.description.count)/\(charLimit)"))
                    .accessibilityIdentifier("DetailText")
            }
            if pickerVisible {
                ImageView(pickerVisible: $pickerVisible, sourceType: $imageSource, action: { (value) in
                    if let image = value {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                            self.inventoryItem.image = image
                        }
                    }
                })
            }
        }
        .padding()
        .navigationBarItems(trailing:
                                Button(action: {
            AVCaptureDevice.requestAccess(for: AVMediaType.video){ response in
                if response && UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                    self.showCameraAlert = false
                    self.imageSource = UIImagePickerController.SourceType.camera
                    self.pickerVisible.toggle()
                } else {
                    self.showCameraAlert = true
                }
            }
        }) {
            Image(systemName: "camera")

        }
            .alert(isPresented: $showCameraAlert) {
                Alert(title: Text("Error"), message: Text("Camera not available"), dismissButton: .default(Text("OK")))
                
            }
        )
    }
}
struct DetailView_Previews: PreviewProvider {
    @State var inventoryItems: InventoryItems
    static let defaultColor = Color.yellow
//    @State static var inventoryItem: InventoryItem
    @State static var inventoryItem = InventoryItem(image: "hare", description: "Hare")
    @State static var favourite: Bool = false
    static var previews: some View {
        DetailView(colour: defaultColor, charLimit: 150, inventoryItem: $inventoryItem)
    }
}
