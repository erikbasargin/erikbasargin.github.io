//
//  MyContentList.swift
//  MyBlog
//
//  Created by Erik Basargin on 02/02/2025.
//

import Ignite

struct MyContentList: HTML {
    
    let articles: [Article]
    
    var body: some HTML {
        VStack(spacing: .large) {
            ForEach(articles) { content in
                VStack(alignment: .leading, spacing: .medium) {
                    VStack(alignment: .leading) {
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
                    
                    TagsSection(article: content)
                }
                .contentBlock()
            }
        }
    }
}
