//
//  MyNavigationBar.swift
//  MyBlog
//
//  Created by Erik Basargin on 29/01/2025.
//

import Foundation
import Ignite

struct MyNavigationBar: HTML {
    
    @Environment(\.siteURL) private var siteURL
    @Environment(\.siteName) private var siteName
    
    var body: some HTML {
        NavigationBar {
            Link("Tags", target: "/tags")
            Link("GitHub", target: "https://github.com/erikbasargin")
        } logo: {
            Text(siteName)
                .font(.title2)
        }
        .navigationItemAlignment(.trailing)
    }
}
