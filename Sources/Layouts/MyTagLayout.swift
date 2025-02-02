//
//  Tags.swift
//  MyBlog
//
//  Created by Erik Basargin on 01/02/2025.
//

import Ignite

@MainActor
struct MyTagLayout: TagLayout {
    
    var body: some HTML {
        let title = if let tag {
            "Selected tag: \(tag)"
        } else {
            "All tags"
        }
        
        Text(title)
            .font(.title3)
            .padding(.vertical, .large)
        
        if tag != nil {
            // Show articles retaled to a tag
            MyContentList(content: content)
        } else {
            TagsSection(tags: content.tags)
        }
        
        Spacer()
    }
}

private extension Array where Element == Content {
    
    @MainActor
    var tags: [String] {
        reduce(into: Set<String>()) { partialResult, content in
            for tag in content.tags {
                partialResult.insert(tag)
            }
        }.sorted()
    }
}
