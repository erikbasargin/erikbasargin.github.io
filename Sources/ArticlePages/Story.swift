//
//  ArticlePage.swift
//  MyBlog
//
//  Created by Erik Basargin on 29/03/2025.
//

import Ignite

struct Story: ArticlePage {
    var body: some HTML {
        Section {
            VStack(spacing: .medium) {
                Text(article.title)
                    .font(.title1)
                
                Text("\(article.estimatedWordCount) words; \(article.estimatedReadingMinutes) minutes to read.")
                    .foregroundStyle(.MyDarkTheme.secondaryAccent)
                
                if let image = article.image {
                    Image(image, description: article.imageDescription)
                        .resizable()
                        .cornerRadius(20)
                        .frame(maxHeight: 300)
                }
            }
            .frame(alignment: .center)
            
            Text(article.text)
                .padding(.top, .medium)
            
            TagsSection(article: article)
        }
        .contentBlock()
    }
}
