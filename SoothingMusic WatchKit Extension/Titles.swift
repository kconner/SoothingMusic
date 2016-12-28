//
//  Titles.swift
//  SoothingMusic
//
//  Created by Kevin Conner on 12/28/16.
//  Copyright © 2016 Kevin Conner. All rights reserved.
//

import Foundation

final class Titles {

    static var random: String {
        switch arc4random_uniform(8) {
        case 0:
            return "Black gesso"
        case 1:
            return "GG"
        case 2:
            return "Why doesn't Bob\nread chat?"
        case 3:
            return "Everybody\nneeds a friend"
        case 4:
            return "Just tap"
        case 5:
            return "This is\nyour world"
        case 6:
            return "You don't want\ntoo much green"
        case 7:
            return "Anybody can do it"
        default:
            return "RUINED"
        }
    }
    
}
