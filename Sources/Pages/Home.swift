import Foundation
import Ignite

struct Home: StaticLayout {
    
    @Environment(\.content) private var content
    
    let title = "Home"
    
    var body: some HTML {
        MyContentList(content: content.typed("article"))
    }
}
