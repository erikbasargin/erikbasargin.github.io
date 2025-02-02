//
//  MyContentList.swift
//  MyBlog
//
//  Created by Erik Basargin on 02/02/2025.
//

import Ignite

struct MyContentList: HTML {
    
    let content: [Content]
    
    var body: some HTML {
        VStack(spacing: .large) {
            ForEach(content) { content in
                VStack(spacing: .medium) {
                    VStack {
                        Link(content)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.MyDarkTheme.accent)
                            .hoverEffect { effect in
                                effect
                                    .foregroundStyle(.MyDarkTheme.secondaryAccent)
                            }
                        
                        Text(content.lastModified.formatted(date: .abbreviated, time: .omitted))
                            .foregroundStyle(.MyDarkTheme.secondaryAccent)
                    }
                    
                    Text(content.description)
                    
                    TagsSection(tags: content.tags)
                }
                .contentBlock()
            }
        }
    }
}
