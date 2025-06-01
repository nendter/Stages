//
//  ContentView.swift
//  StageB
//
//  Created by Niklas Endter on 01.06.25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var items: [StackItem] = [];
    @State private var configuring: Bool = false;
    
    var body: some View {
        ZStack {
            Rectangle().fill(BACKGROUND)
            StackView(items: $items)
            
            // Management Overlay
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        configuring = true;
                    }) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: SPACING_200, height: SPACING_200)
                            .padding(SPACING)
                            .background(BACKGROUND_300)
                            .foregroundColor(FOREGROUND)
                            .clipShape(RoundedRectangle(cornerRadius: BORDER_RADIUS, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: BORDER_RADIUS, style: .continuous)
                                    .stroke(BORDER_300, lineWidth: BORDER_WIDTH)
                            )
                            .shadow(radius: SHADOW_RADIUS_200)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }.padding(SPACING_200)
            
            // Configure Overlay
            
            if (configuring) {
                Rectangle().fill(Color(hex: 0x000000, alpha: 0.25)).onTapGesture {
                    configuring = false;
                }
                ConfigureView(updateConfig: updateConfig)
            }
        }

    }
    
    func updateConfig(i: [StackItem]) {
        items = i;
        configuring = false;
    }
    
}
