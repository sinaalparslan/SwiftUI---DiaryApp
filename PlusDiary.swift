import SwiftUI

struct PlusDiary: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State  var title: String = ""
    @State  var explanation: String = ""
    @State  var selectedEmoji: String = "😊" // Varsayılan emoji
    @State  var isPickerPresented = false
    @EnvironmentObject var alertViewModel: AlertView
    @Environment(\.presentationMode) private var presentationMode

    @Binding var item : Item?

    let allEmojis = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "😊", "😇", "🙂", "🙃",
                     "😉", "😌", "😍", "😘", "😗", "😙", "😚", "😋", "😛", "😝", "😜", "🤪",
                     "😎", "🤓", "😏", "😒", "😞", "😔", "😟", "😕", "🙁", "☹️", "😣", "😖",
                     "😫", "😩", "😤", "😠", "😡", "😶‍🌫️", "😐", "😑", "😯", "😦", "😧", "😮",
                     "😲", "🥱", "😴", "🤤", "😪", "😵", "🤐", "🥴", "🤢", "🤮", "🤧", "😷",
                     "🤒", "🤕", "🤑", "🤠", "😈", "👿", "👹", "👺", "🤡", "💩", "👻", "💀",
                     "☠️", "👽", "👾", "🤖", "😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿",
                     "😾","👩", "👨", "🧑", "👧", "👦", "👶", "👵", "👴", "👲", "👳", "🧕",
                     "👱‍♀️", "👱‍♂️","🧔", "👮", "👷", "💂", "🕵️‍♀️", "🕵️‍♂️", "👩‍⚕️", "👨‍⚕️", "👩‍🌾", "👨‍🌾",
                     "👩‍🍳","👨‍🍳", "👩‍🎓", "👨‍🎓", "👩‍🎤", "👨‍🎤", "👩‍🏫", "👨‍🏫", "👩‍🏭", "👨‍🏭", "👩‍💻","👨‍💻",
                     "👩‍💼", "👨‍💼", "👩‍🔧", "👨‍🔧", "👩‍🔬", "👨‍🔬", "👩‍🎨", "👨‍🎨", "👩‍🚒","👨‍🚒", "👩‍✈️", "👨‍✈️",
                     "👩‍🚀", "👨‍🚀", "👩‍⚖️", "👨‍⚖️", "👰", "🤵", "👸", "🤴"]

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isPickerPresented.toggle()
                }) {
                    Text(selectedEmoji)
                        .font(.system(size: 30))
                }
                .frame(width: 60, height: 60)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding()

                TextField("Title", text: $title)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            }

            Section(header: Text("Explanation")) {
                TextEditor(text: $explanation)
                    .frame(minHeight: 100, maxHeight: .infinity)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .background(Color.white)
                    .cornerRadius(10)
                    .multilineTextAlignment(.leading)
                    .onChange(of: explanation) { _ in
                        // Açıklama değiştiğinde yapılacak işlemler
                    }
                    .onAppear {
                        UITextView.appearance().backgroundColor = .white // Arkaplan rengini ayarla
                    }
            }
            .padding()
        }.onAppear{
            if let _item = item{
                self.explanation = _item.explanation!
                self.title = _item.title!
                self.selectedEmoji = _item.emoji!
                

            }
        }
        .background(Color.white)
        .sheet(isPresented: $isPickerPresented) {
            EmojiPickerView(selectedEmoji: $selectedEmoji, isPickerPresented: $isPickerPresented, allEmojis: allEmojis)
        }
        .overlay(
            HStack {
                Spacer()
                Text("New Diary")
                    .font(.title)
                    .bold()
                Spacer()
            }
                .position(.init(x: UIScreen.main.bounds.width / 2, y: -60)) 
        )
        .navigationBarItems(trailing: Button(action: {
            if title.isEmpty || explanation.isEmpty{
                self.alertViewModel.showalert(title: "Empty Field !!!", description: "You have to enter value")
            }else{
                addItem()
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Image(systemName: "plus.square")
        })
        .alert(isPresented: $alertViewModel.showalert) {
            Alert(title: Text(alertViewModel.title), message: Text(alertViewModel.description), dismissButton: .default(Text("OK")))
        }
    }
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = title
            newItem.explanation = explanation
            newItem.emoji = selectedEmoji

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                debugPrint(nsError.localizedDescription)
            }
        }
    }
}

struct EmojiPickerView: View {
    @Binding var selectedEmoji: String
    @Binding var isPickerPresented: Bool
    let allEmojis: [String]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))], spacing: 10) {
                ForEach(allEmojis, id: \.self) { emoji in
                    Button(action: {
                        selectedEmoji = emoji
                        isPickerPresented = false
                    }) {
                        Text(emoji)
                            .font(.title)
                            .padding()
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
            .padding()
    }
}
