//
//  MyContentBlockModifier.swift
//  MyBlog
//
//  Created by Erik Basargin on 02/02/2025.
//

import Ignite

extension HTML {
    
    func contentBlock() -> some HTML {
        padding()
            .cornerRadius(6)
            .shadow(radius: 6)
            .background(.MyDarkTheme.contentBackground)
    }
}
