//
//  MyNavigationBar.swift
//  MyBlog
//
//  Created by Erik Basargin on 29/01/2025.
//

import Foundation
import Ignite

struct MyNavigationBar: HTML {
    
    @Environment(\.site) private var site
    
    var body: some HTML {
        NavigationBar {
            Link("Tags", target: "/tags")
            Link("GitHub", target: "https://github.com/erikbasargin")
        } logo: {
            Text(site.name)
                .font(.title2)
        }
        .navigationItemAlignment(.trailing)
    }
}
