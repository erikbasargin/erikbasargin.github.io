//
//  Tags.swift
//  MyBlog
//
//  Created by Erik Basargin on 01/02/2025.
//

import Ignite

@MainActor
struct Tags: TagPage {
    
    @Environment(\.articles) private var articles
    
    var body: some HTML {
        let tags = Set(articles
            .all
            .compactMap(\.keyedTagLinks)
            .flatMap(\.self)
        ).sorted { $0.key < $1.key }
        
        let selectedTag = tags.first { $0.key == tag.name }
        
        HStack {
            ForEach(tags) { tag in
                Badge(tag.link)
                    .badgeStyle(.subtle)
                    .role(selectedTag == tag ? .primary : .dark)
                    .font(.title6)
            }
        }
        .padding()
        .contentBlock()
        .margin(.bottom, .large)
        
        MyContentList(articles: tag.articles.filter({ $0.tags?.isEmpty == false }))
    }
}

private extension Array where Element == Article {
    
    @MainActor
    var tagLinks: [Link] {
        self.compactMap { article in
            article.tagLinks(style: .plain)
        }
        .flatMap(\.self)
    }
}

private struct KeyedLink: Hashable {
    let key: String
    let link: Link
    
    static func == (lhs: KeyedLink, rhs: KeyedLink) -> Bool {
        lhs.key == rhs.key
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
}

private extension Article {
    
    var keyedTagLinks: [KeyedLink]? {
        guard let tags = metadata["tags"] as? String else { return nil }
        
        let targets: [(name: String, path: String)] = tags.splitAndTrim().map { tag in
            let tagPath = tag.convertedToSlug()
            return (name: tag, path: "/tags/\(tagPath)")
        }
        
        guard !targets.isEmpty else { return nil }
        
        return targets.map { target in
            let tag = Link(target.name, target: target.path)
                .relationship(.tag)
            return KeyedLink(key: target.name, link: tag)
        }
    }
}

private extension String {
    
    func splitAndTrim() -> [String] {
        self.split(separator: ",", omittingEmptySubsequences: true)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}
