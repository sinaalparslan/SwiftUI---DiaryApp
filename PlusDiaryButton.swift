//
//  PlusDiary.swift
//  Diary
//
//  Created by sina on 16.02.2024.
//

import SwiftUI

struct PlusDiaryButton: View {

    var body: some View {

        Text("+")
            .padding()
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .background(Color.orange)
            .foregroundColor(.white)
            .mask(Circle())
    }
}

struct PlusDiaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusDiaryButton()
    }

}
