//
//  ArticlePage.swift
//  MyBlog
//
//  Created by Erik Basargin on 29/03/2025.
//

import Ignite

struct PrivacyPolicy: ArticlePage {
    var body: some HTML {
        Section {
            VStack(spacing: .medium) {
                Text(article.title)
                    .font(.title1)
                
                Text("Effective Date: \(article.lastModified.formatted(date: .numeric, time: .omitted))")
                    .foregroundStyle(.MyDarkTheme.secondaryAccent)
            }
            .frame(alignment: .center)
            
            Text(article.text)
                .padding(.top, .medium)
        }
        .contentBlock()
    }
}
