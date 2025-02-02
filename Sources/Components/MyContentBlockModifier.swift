//
//  MyContentBlockModifier.swift
//  MyBlog
//
//  Created by Erik Basargin on 02/02/2025.
//

import Ignite

struct MyContentBlockModifier: HTMLModifier {
    
    func body(content: some HTML) -> any HTML {
        content
            .padding()
            .cornerRadius(6)
            .shadow(radius: 6)
            .background(.MyDarkTheme.contentBackground)
    }
}

extension HTML {
    
    func contentBlock() -> some HTML {
        modifier(MyContentBlockModifier())
    }
}
