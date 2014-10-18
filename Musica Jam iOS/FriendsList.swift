//
//  FriendsList.swift
//  Musica Jam iOS
//
//  Created by Dan Hoang on 10/18/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

import Foundation

class FriendsList {
    
    var friends = [Profile]()
    var bestFriends = [Profile]()
    
    init() {
        
    }
    
    func getFriends() -> [Profile] {
        return self.friends
    }
    
    func addFriend(friend : Profile) {
        self.friends.append(friend)
    }

    func removeFriend(friend : Profile) {
    }
}