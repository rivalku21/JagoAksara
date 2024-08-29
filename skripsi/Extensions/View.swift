//
//  View.swift
//  skripsi
//
//  Created by Rival Fauzi on 03/02/24.
//

import Foundation
import SwiftUI

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .white
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    func customFont() -> some View {
        self.modifier(CustomFontModifier())
    }
}

struct CustomFontKey: EnvironmentKey {
    static let defaultValue: Font = .custom("SFProRounded-Regular", size: 16)
}

extension EnvironmentValues {
    var customFont: Font {
        get { self[CustomFontKey.self] }
        set { self[CustomFontKey.self] = newValue }
    }
}

struct CustomFontModifier: ViewModifier {
    @Environment(\.customFont) var customFont

    func body(content: Content) -> some View {
        content.font(customFont)
    }
}
