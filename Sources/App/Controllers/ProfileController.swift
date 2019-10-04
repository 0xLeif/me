import Vapor
import Leaf

class ProfileController: RouteCollection {
    let profile = ProfileContext(title: "Hello World",
                                 name: "Zach Eriksen",
                                 bio: "Swift Developer",
                                 email: "zmeriksen@icloud.com",
                                 phone: "",
                                 location: "Remote",
                                 socialMedia: [
                                    Social(title: "Twitter", url: "https://www.twitter.com/zmeriksen"),
                                    Social(title: "LinkedIn", url: "https://www.linkedin.com/in/zmeriksen/"),
                                    Social(title: "GitHub", url: "https://github.com/zmeriksen"),
                                    Social(title: "GitLab", url: "https://gitlab.com/_leif"),
                                    Social(title: "Medium", url: "https://medium.com/@_leif")
        ],
                                 experiences: [
                                    
                                    Experience(title: "iOS Developer", company: "From Now On", time: "Aug 2019 - Present", description: "Lead iOS Developer working on the FanX platform. FanX platform has over 70 schools. Developed Augmented Reality feature for ticket scanning."),
                                    Experience(title: "iOS Developer", company: "Client Resources Inc", time: "Jan 2017 - Aug 2019", description: "As an iOS Developer for the Solutions Center in CRi I worked on Arvest Go, a native iOS app, along with other iOS apps. My work at CRi has also focused on mobile automation, innovation, and ADA (Americans Disabilities Act)"),
                                    Experience(title: "iOS Developer", company: "University of Nebraska at Omaha", time: "Aug 2014 - Jan 2017", description: "I was the iOS developer for the Attic at the University of Nebraska Omaha and worked on apps such as, MavMate, PricePoint, etc. Also I have worked on Unity3D projects, zSpace, Range of Motion, and Four Forces.")
        ],
                                 skills: [
                                    Skill(title: "Swift"),
                                    Skill(title: "Vapor", description: "Backend Swift Web Framework")
        ],
                                 links: [
                                    Link(title: "oneleif",  url: "https://oneleif.github.io/olPages/", description: "Open Source Development Group"),
                                    Link(title: "twoleif", url: "https://www.twoleif.com"),
                                    Link(title: "Blogs for CRi", url: "https://www.clientresourcesinc.com/author/zeriksen/"),
                                    Link(title: "Learn Swift Omaha!", url: "https://www.meetup.com/LearnSwiftOmaha/")
    ])
    
    func boot(router: Router) throws {
        router.get(use: indexLightThemeHandler)
        
        router.get("/light", use: indexLightThemeHandler)
        router.get("/dark", use: indexDarkThemeHandler)
    }
    
    func indexDarkThemeHandler(_ req: Request) throws -> Future<View> {
        let context = PageContext(isDarkTheme: true,
                                  fontColor: "white",
                                  backgroundColor: "black",
                                  profile: profile)
        
        return try req.view().render("index", context)
    }
    
    func indexLightThemeHandler(_ req: Request) throws -> Future<View> {
        let context = PageContext(isDarkTheme: false,
                                  fontColor: "black",
                                  backgroundColor: "white",
                                  profile: profile)
        
        return try req.view().render("index", context)
        
    }
}

struct Social: Encodable {
    let title: String
    let url: String
}

struct Experience: Encodable {
    let title: String
    let company: String
    let time: String
    let description: String?
    
    init(title: String, company: String, time: String, description: String? = nil) {
        self.title = title
        self.company = company
        self.time = time
        self.description = description
    }
}

struct Skill: Encodable {
    let title: String
    let description: String?
    
    init(title: String, description: String? = nil) {
        self.title = title
        self.description = description
    }
}

struct Link: Encodable {
    let title: String
    let description: String?
    let url: String
    
    init(title: String, url: String, description: String? = nil) {
        self.title = title
        self.description = description
        self.url = url
    }
}

struct ProfileContext: Encodable {
    // Profile Info
    let title: String
    let name: String
    let bio: String
    let email: String
    let phone: String
    let location: String
    let socialMedia: [Social]
    // Work Experience
    let experiences: [Experience]
    // Awards / Skills
    let skills: [Skill]
    // Links
    let links: [Link]
}

struct PageContext: Encodable {
    // Settings
    let isDarkTheme: Bool
    let fontColor: String
    let backgroundColor: String
    // Profile
    let profile: ProfileContext
}
