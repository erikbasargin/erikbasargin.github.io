//
//  MyFooter.swift
//  MyBlog
//
//  Created by Erik Basargin on 01/02/2025.
//

import Foundation
import Ignite

struct MyFooter: HTML {
    
    var body: some HTML {
        VStack {
            CodeBlock(.swift) {
                "©\(Calendar.current.component(.year, from: .now)) Erik Basargin"
            }
            .background(.clear)
            
            Text {
                "Powered by "
                Link("Ignite", target: URL(static: "https://github.com/twostraws/Ignite"))
            }
        }
        .frame(alignment: .center)
        .margin(.vertical, .xLarge)
        .font(.system(size: .px(12)))
    }
}
