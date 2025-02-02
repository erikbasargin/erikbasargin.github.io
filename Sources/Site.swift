import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        let site = ExampleSite()
        
        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ExampleSite: Site {    
    let name = "Swift Voyage"
    let titleSuffix = " – Erik's Blog"
    let author = "Erik Basargin"
    let builtInIconsEnabled = true
    let syntaxHighlighters: [HighlighterLanguage] = [
        .swift,
    ]
    
    var url: URL {
        if let urlString = ProcessInfo.processInfo.environment["WEBSITE_BASE_URL"] {
            URL(string: urlString)!
        } else {
            URL(static: "http://localhost:8000")
        }
    }
    
    let homePage = Home()
    let layout = MainLayout()
    let tagLayout = MyTagLayout()
    let lightTheme: (any Theme)? = nil
    let darkTheme: (any Theme)? = MyDarkTheme()
    
    var contentLayouts: [any ContentLayout] {
        ArticleContentLayout()
    }
}

struct MyDarkTheme: DarkTheme {
    static var name: String = "dark"
    let accent: Color = .MyDarkTheme.accent
    let secondaryAccent: Color = .MyDarkTheme.secondaryAccent
    let heading: Color = .MyDarkTheme.accent
    let link: Color = .MyDarkTheme.accent
    let linkDecoration: TextDecoration = .none
    let syntaxHighlighterTheme: HighlighterTheme = .xcodeDark
    
    let background: Color = .MyDarkTheme.background
    
    let mediumMaxWidth: LengthUnit = .px(768)
    let largeMaxWidth: LengthUnit = .px(768)
    let xLargeMaxWidth: LengthUnit = .px(768)
    let xxLargeMaxWidth: LengthUnit = .px(768)
}


extension Color {
    
    enum MyDarkTheme {
        
        static var accent: Color {
            Color(hex: "#6eb6ff")
        }
        
        static var secondaryAccent: Color {
            Color(hex: "#c7d5f6")
        }
        
        static var background: Color {
            Color(hex: "#0d1117")
        }
        
        static var contentBackground: Color {
            Color(hex: "#21262d")
        }
    }
}
