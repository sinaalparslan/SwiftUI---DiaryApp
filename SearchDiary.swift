//
//  SearchDiary.swift
//  Diary
//
//  Created by sina on 18.02.2024.
//

import Foundation

class SearchDiary : ObservableObject {
    @Published var items: [Item] = []
    func onApperar(){
        getItems(searchText: "")
    }
    func getItems(searchText:String){
        PersistanceController.shared.getByItems(query: searchText){
            items in self.items = items
        }
    }
}
