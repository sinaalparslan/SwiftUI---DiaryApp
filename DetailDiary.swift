//
//  DetailDiary.swift
//  Diary
//
//  Created by sina on 17.02.2024.
//

import SwiftUI

struct DetailDiary: View {
    var item: Item
    var body: some View {
        Text(item.title ?? "")
    }
}
