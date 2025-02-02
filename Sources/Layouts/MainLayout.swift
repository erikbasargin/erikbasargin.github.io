import Foundation
import Ignite

struct MainLayout: Layout {
    
    var body: some HTML {
        HTMLDocument {
            HTMLHead(for: page)
            
            HTMLBody {
                MyNavigationBar()
                
                Section(page.body)
                    .padding(.top, .large)
                
                Section {
                    MyFooter()
                }
            }
        }
    }
}
