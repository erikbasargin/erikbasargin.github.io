//
//  Apps.swift
//  MyBlog
//
//  Created by Erik Basargin on 09/11/2025.
//

import Foundation
import Ignite

struct Apps: StaticPage {
    
    @Environment(\.articles) private var articles
    
    let title = "Apps"
    
    var body: some HTML {
        MyAppsGrid(articles: articles.typed("app"))
    }
}
