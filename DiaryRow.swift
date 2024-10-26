//
//  DiaryRow.swift
//  Diary
//
//  Created by sina on 17.02.2024.
//

import SwiftUI

struct DiaryRow: View {
    var item: Item
    var itemFormatter: DateFormatter
    var body: some View {
        HStack{
            Text(item.emoji ?? "").font(.title)
            VStack(alignment: .leading){
                Text("\(item.timestamp!, formatter: itemFormatter)")
                Text(item.title ?? "")
                Text(item.explanation ?? "").foregroundStyle(.secondary)
        }
            Spacer()
            Image.init(systemName: "chevron.right").foregroundColor(.gray)
        }
    }
}
