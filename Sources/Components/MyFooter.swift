//
//  MyFooter.swift
//  MyBlog
//
//  Created by Erik Basargin on 01/02/2025.
//

import Foundation
import Ignite

public struct MyFooter: HTML {
    public init() {}

    public var body: some HTML {
        VStack {
            Text("©\(Calendar.current.component(.year, from: .now)) Erik Basargin.")
            Text {
                "Powered by "
                Link("Ignite", target: URL(static: "https://github.com/twostraws/Ignite"))
            }
        }
        .horizontalAlignment(.center)
        .margin(.vertical, .xLarge)
        .font(.system(size: .px(12)))
    }
}
