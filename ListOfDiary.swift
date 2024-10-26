//
//  ListOfDiary.swift
//  Diary
//
//  Created by sina on 16.02.2024.
//

import SwiftUI



struct ListOfDiary: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var items: [Item] = []
    @ObservedObject var viewModel = SearchDiary()
    @State var actionselection: Int? = nil
    @State var searchText = ""
    @State private var item : Item? = nil

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing){
                NavigationLink(
                    destination: PlusDiary(item:$item),
                                    tag: 1,
                                    selection: $actionselection){
                                        EmptyView()
                                    }

                List{
                    ForEach(viewModel.items) { item in
                        Button.init{
                            self.item = item
                            self.actionselection = 1

                        } label: {
                            DiaryRow(item: item, itemFormatter: itemFormatter)
                        }


                    }
                }.onAppear(perform: viewModel.onApperar)
                    .searchable(text:$searchText, prompt: "Search".localizedLowercase).onChange(of:searchText){newValue in viewModel.getItems(searchText: newValue)}
                Button {
                    self.actionselection = 1
                    
                } label: {
                    HStack{
                        Spacer()
                        PlusDiaryButton()
                            .padding(.bottom,30)
                            .padding(.leading)
                        Spacer()}
                }

            }.navigationTitle(Text("MyDiarys"))

        }
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

struct ListOfDiary_Previews: PreviewProvider {
    static var previews: some View {
        ListOfDiary()
    }

}
