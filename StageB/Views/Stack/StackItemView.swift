//
//  StackItemView.swift
//  StageB
//
//  Created by Niklas Endter on 01.06.25.
//

import SwiftUI

struct StackItem: Hashable {
    let url: String;
    let backdrop: Bool;
    
    init(url: String, backdrop: Bool = false) {
        self.url = url
        self.backdrop = backdrop
    }
}

private struct StackItemLayout {
    var position: CGSize = CGSize(width: 0, height: 0); // Last static position
    var offset: CGSize? = nil; // Current dragging offset
    var size: CGSize = CGSize(width: 256, height: 256); // Last static size
    var overflow: CGSize? = nil; // Current dragging size
}

struct StackItemView: View {
    @State var item: StackItem;
    @State private var layout: StackItemLayout;
    @State var cursor: NSCursor? = nil;
    
    init(item: StackItem) {
        self.item = item
        self.layout = StackItemLayout();
    }
    
    var body: some View {
        ZStack {
            WebView(url: URL(string: item.url)!)
                .if(!item.backdrop) { view in
                    view.clipShape(RoundedRectangle(cornerRadius: BORDER_RADIUS_200, style: .continuous))
                    .padding(SPACING)
                    .background(BACKGROUND_200)
                    .clipShape(RoundedRectangle(cornerRadius: BORDER_RADIUS_300, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: BORDER_RADIUS_300, style: .continuous)
                            .stroke(BORDER_200, lineWidth: BORDER_WIDTH)
                    )
                    .frame(width: getWidth(temp: true), height: getHeight(temp: true))
                    .position(getPosition(temp: true))
                }
            
            // Interactions Overlay
            if (!item.backdrop) {
                VStack {
                    Rectangle().fill(Color(hex: 0x000000, alpha: 0.001)).frame(height: 24.0)
                        .gesture(
                            DragGesture().onChanged { value in
                                setCursor(c: .closedHand)
                                layout.offset = value.translation
                            }.onEnded { value in
                                layout.position.width += value.translation.width;
                                layout.position.height += value.translation.height;
                                layout.offset = nil;
                                setCursor(c: nil)
                            }
                        )
                        .onContinuousHover { phase in
                            switch phase {
                            case .active:
                                setCursor(c: .openHand)
                            case .ended:
                                setCursor(c: nil)
                            }
                        }
                    Spacer()
                    HStack {
                        Spacer()
                        Rectangle().fill(Color(hex: 0x000000, alpha: 0.001)).frame(width: 32, height: 32)
                            .gesture(
                                DragGesture().onChanged { value in
                                    layout.overflow = value.translation;
                                    if (layout.offset == nil) {
                                        layout.offset = CGSize(width: 0, height: 0);
                                    }
                                    layout.offset!.width = value.translation.width / 2;
                                    layout.offset!.height = value.translation.height / 2;
                                }.onEnded { value in
                                    layout.size.width += value.translation.width;
                                    layout.size.height += value.translation.height;
                                    layout.overflow = nil;
                                    layout.offset = nil;
                                }
                            )
                    }
                }
                .frame(width: getWidth(), height: getHeight())
                .position(getPosition())
            }
        }
        .shadow(radius: SHADOW_RADIUS_300)
    }
    
    func setCursor(c: NSCursor?) {
        if (cursor == c) {
            return;
        }
        if (cursor != nil) {
            NSCursor.pop();
        }
        if (c != nil) {
            c!.push();
        }
        cursor = c;
    }
    
    func getPosition(temp: Bool = false) -> CGPoint {
        var point = CGPoint(x: layout.position.width, y: layout.position.height);
        point.x += layout.size.width / 2;
        point.y += layout.size.height / 2;
        if (temp && layout.offset != nil) {
            point.x += layout.offset!.width;
            point.y += layout.offset!.height;
        }
        return point;
    }
    
    func getWidth(temp: Bool = false) -> CGFloat {
        var width = layout.size.width;
        if (temp && layout.overflow != nil) {
            width += layout.overflow!.width;
        }
        return width;
    }
    
    func getHeight(temp: Bool = false) -> CGFloat {
        var height = layout.size.height;
        if (temp && layout.overflow != nil) {
            height += layout.overflow!.height;
        }
        return height;
    }
    
}
