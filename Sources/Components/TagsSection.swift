//
//  TagsSection.swift
//  MyBlog
//
//  Created by Erik Basargin on 02/02/2025.
//

import Ignite

struct TagsSection: HTML {
    
    let tags: [String]
    
    var body: some HTML {
        Section {
            ForEach(tags) { tag in
                Link(
                    Badge(tag).badgeStyle(.subtleBordered).role(.dark),
                    target: "/tags/\(tag)"
                )
            }
        }
    }
}
