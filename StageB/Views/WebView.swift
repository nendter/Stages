//
//  Section.swift
//  StageB
//
//  Created by Niklas Endter on 01.06.25.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration();
        config.mediaTypesRequiringUserActionForPlayback = [];
        let webView = WKWebView(frame: .zero, configuration: config);
        let request = URLRequest(url: url);
        webView.load(request);
        return webView;
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.load(URLRequest(url: url))
    }
}
