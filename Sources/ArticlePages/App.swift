//
//  ArticlePage.swift
//  MyBlog
//
//  Created by Erik Basargin on 29/03/2025.
//

import Ignite

struct App: ArticlePage {
    var body: some HTML {
        Section {
            HStack(spacing: .medium) {
                Spacer()
                
                if let imagePath = article.image {
                    Image(imagePath, description: article.imageDescription)
                        .resizable()
                        .frame(width: .percent(.init(10)), height: .percent(.init(10)))
                }
                
                Text(article.title)
                    .font(.title1)
                
                Spacer()
            }
            
            Text(article.text)
                .padding(.top, .medium)
            
            TagsSection(article: article)
        }
        .contentBlock()
    }
}
