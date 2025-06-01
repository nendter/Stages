//
//  ConfigureView.swift
//  StageB
//
//  Created by Niklas Endter on 01.06.25.
//

import SwiftUI

struct ConfigureView: View {
    
    @State var updateConfig: ([StackItem]) -> Void;
    
    @State var contentUrl: String = "";
    @State var reactionUrl: String = "";
    
    var body: some View {
        VStack(spacing: SPACING) {
            TextField("Content URL...", text: $contentUrl)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: SPACING, bottom: 0, trailing: SPACING))
                .frame(width: INPUT_ELEMENT_WIDTH, height: INPUT_ELEMENT_HEIGHT)
                .background(BACKGROUND_200)
                .clipShape(RoundedRectangle(cornerRadius: BORDER_RADIUS, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: BORDER_RADIUS, style: .continuous)
                        .stroke(BORDER_200, lineWidth: BORDER_WIDTH)
                )
            TextField("Reaction URL...", text: $reactionUrl)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: SPACING, bottom: 0, trailing: SPACING))
                .frame(width: INPUT_ELEMENT_WIDTH, height: INPUT_ELEMENT_HEIGHT)
                .background(BACKGROUND_200)
                .clipShape(RoundedRectangle(cornerRadius: BORDER_RADIUS, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: BORDER_RADIUS, style: .continuous)
                        .stroke(BORDER_200, lineWidth: BORDER_WIDTH)
                )
            Button(action: {
                onLoad();
            }) {
                Text("Load")
                    .padding(SPACING)
                    .frame(width: INPUT_ELEMENT_WIDTH, height: INPUT_ELEMENT_HEIGHT)
                    .background(BACKGROUND_300)
                    .clipShape(RoundedRectangle(cornerRadius: BORDER_RADIUS, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: BORDER_RADIUS, style: .continuous)
                            .stroke(BORDER_300, lineWidth: BORDER_WIDTH)
                    )
                    .shadow(radius: SHADOW_RADIUS_200)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(EdgeInsets.init(top: SPACING, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(SPACING_200)
        .background(BACKGROUND)
        .clipShape(RoundedRectangle(cornerRadius: BORDER_RADIUS_200, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: BORDER_RADIUS_200, style: .continuous)
                .stroke(BORDER, lineWidth: BORDER_WIDTH)
        )
        .shadow(radius: SHADOW_RADIUS_300)
    }
    
    func onLoad() {
        updateConfig([
            StackItem(url: contentUrl, backdrop: true),
            StackItem(url: reactionUrl)
        ])
    }
    
}
