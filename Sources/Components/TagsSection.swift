//
//  TagsSection.swift
//  MyBlog
//
//  Created by Erik Basargin on 02/02/2025.
//

import Ignite

struct TagsSection: HTML {
    
    let article: Article
    
    var body: some HTML {
        if let tags = article.tagLinks(style: .plain), !tags.isEmpty {
            HStack {
                ForEach(tags) { tag in
                    Badge(tag)
                        .badgeStyle(.subtleBordered)
                        .role(.dark)
                }
            }
        }
    }
}
