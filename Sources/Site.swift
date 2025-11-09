import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        var site = ExampleSite()
        
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
    
    let prettifyHTML: Bool = false // fix for https://github.com/twostraws/Ignite/issues/474
    
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
    let tagPage = Tags()
    let layout = MainLayout()
    
    let lightTheme: (any Theme)? = MyDarkTheme()
    let darkTheme: (any Theme)? = nil
    
    var articlePages: [any ArticlePage] {
        Story()
        App()
        PrivacyPolicy()
    }
    
    var staticPages: [any StaticPage] {
        Apps()
    }
}

struct MyDarkTheme: Theme {
    
    let colorScheme: Ignite.ColorScheme = .dark
    let syntaxHighlighterTheme: HighlighterTheme = .xcodeDark
    
    let accent: Color = .MyDarkTheme.accent
    let secondaryAccent: Color = .MyDarkTheme.secondaryAccent
    let heading: Color = .MyDarkTheme.accent
    let link: Color = .MyDarkTheme.accent
    let linkDecoration: TextDecoration = .none
    
    let background: Color = .MyDarkTheme.background
    var secondary: Color = .red
    var tertiaryBackground: Color = .blue
    
    var siteWidth: ResponsiveValues<LengthUnit> {
        .init(
            nil,
            small: nil,
            medium: .px(768),
            large: .px(768),
            xLarge: .px(768),
            xxLarge: .px(768)
        )
    }
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
