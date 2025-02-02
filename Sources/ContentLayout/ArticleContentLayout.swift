//
//  Story.swift
//  MyBlog
//
//  Created by Erik Basargin on 31/01/2025.
//

import Foundation
import Ignite

struct ArticleContentLayout: ContentLayout {
    var body: some HTML {
        Section {
            VStack(spacing: .medium) {
                Text(content.title)
                    .font(.title1)
                
                Text("\(content.estimatedWordCount) words; \(content.estimatedReadingMinutes) minutes to read.")
                    .foregroundStyle(.MyDarkTheme.secondaryAccent)
                
                if let image = content.image {
                    Image(image, description: content.imageDescription)
                        .resizable()
                        .cornerRadius(20)
                        .frame(maxHeight: 300)
                }
            }
            .frame(alignment: .center)
            
            Text(content.body)
                .padding(.top, .medium)
            
            if content.hasTags {
                TagsSection(tags: content.tags)
                    .padding(.top, .medium)
            }
        }
        .contentBlock()
    }
}
