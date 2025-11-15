import Foundation
import Ignite

struct MainLayout: Layout {
    
    var body: some Document {
        Body {
            MyNavigationBar()
            
            content
                .padding(.top, .large)
            
            MyFooter()
        }
    }
}
