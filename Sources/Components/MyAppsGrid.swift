//
//  MyAppsGrid.swift
//  MyBlog
//
//  Created by Erik Basargin on 09/11/2025.
//

import Ignite

struct MyAppsGrid: HTML {
    
    let articles: [Article]
    
    var body: some HTML {
        Grid {
            ForEach(articles) { content in
                VStack(alignment: .center) {
                    if let imagePath = content.image {
                        Image(imagePath, description: content.imageDescription)
                            .resizable()
                            .frame(width: .percent(.init(30)), height: .percent(.init(30)))
                    }
                    
                    Link(content)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.MyDarkTheme.accent)
                }
            }
        }
    }
}
