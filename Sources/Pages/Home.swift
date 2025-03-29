import Foundation
import Ignite

struct Home: StaticPage {
    
    @Environment(\.articles) private var articles
    
    let title = "Home"
    
    var body: some HTML {
        MyContentList(articles: articles.all)
    }
}
