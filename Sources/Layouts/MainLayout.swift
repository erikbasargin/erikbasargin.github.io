import Foundation
import Ignite

struct MainLayout: Layout {
    
    var body: some HTML {
        Body {
            MyNavigationBar()
            
            content
                .padding(.top, .large)
            
            MyFooter()
        }
    }
}
