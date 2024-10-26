//
//  AlertView.swift
//  Diary
//
//  Created by sina on 17.02.2024.
//

import Foundation

class AlertView : ObservableObject{
    @Published var showalert = false
    @Published var title = ""
    @Published var description = ""

    func showalert(title: String, description: String){
        self.title = title
        self.description = description
        self.showalert = true
    }
}
