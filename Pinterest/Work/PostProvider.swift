//
//  P.swift
//  Periscope
//
//  Created by Zac Workman on 18/01/2019.
//  Copyright © 2019 Zac Workman. All rights reserved.
//

import UIKit

class PostProvider {
    
    static func GetPosts() -> [Post] {
        return [
            Post(image: UIImage(named: "1")!,
                 title: "M I N I M A L I S T A",
                 description: "This list is a snap shot in time but sure to dynamically change. You can already add www.classpager.com to the list. Please add your newly discovered EdApps."),
            Post(image: UIImage(named: "2")!,
                 title: "There's a music app for that!",
                 description: "There is a Music App for That Infographic Infografía sobre apps de música vía @numanmusic"),
            Post(image: UIImage(named: "3")!,
                 title: "Out With the Old, In With the New",
                 description: "New fall catalogs are coming out soon. Now what to do with all these old catalogs… If you’re a consultant who, like me, has extra catalogs from the spring, these are still very valuable!"),
            Post(image: UIImage(named: "4")!,
                 title: "Wall art available on grindstore.",
                 description: "Wine Bottle Votives - Add some much needed light to your dark den and support a good cause at the same time with these Wine Bottle Votives."),
            Post(image: UIImage(named: "5")!,
                 title: "New Architectural Sculptures by David Moreno Appear As Three Dimensional Drawings (Colossal)",
                 description: "Spanish sculptor David Moreno (previously) continues to blur the lines between two and three dimensions with his architectural artworks."),
            Post(image: UIImage(named: "6")!,
                 title: "Everything You Wanted To Know About TOR And The Deep Web #infographic",
                 description: "In an age when people post their most private moments on the internet, it may come as a surprise that one of the biggest concerns this year is online privacy. Ever since the story broke about the leaked Edward Snowden documents regarding spying by the NSA the whole world got a little more paranoid.")
        ]
    }
    
}
