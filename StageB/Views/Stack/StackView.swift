//
//  StackView.swift
//  StageB
//
//  Created by Niklas Endter on 01.06.25.
//

import SwiftUI

struct StackView: View {
    
    @Binding var items: [StackItem];
    
    var body: some View {
        ZStack(alignment: .center) {
            ForEach(items, id:\.self) { item in
                StackItemView(item: item)
            }
        }
    }
}
