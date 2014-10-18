//
//  Profile.swift
//  Musica Jam iOS
//
//  Created by Dan Hoang on 10/18/14.
//  Copyright (c) 2014 Dan Hoang. All rights reserved.
//

import Foundation
import MediaPlayer

class Profile {
    
    private var userName : String!
    private var password : String!
    private var name : String!
    private var age : Int
    private var town : String!
    private var moviePlayerController = MPMoviePlayerController()
//    private var clips = [URL]()
    private var friends : FriendsList!
    private var instruments = [String]()
    private var gender : Int
    private var genres = [String]()
    
    init() {
        self.age = -1
        self.gender = -1
    }
    func setUserName(userName : String) {
        self.userName = userName
    }
    func getUserName() -> String {
        return self.userName
    }
    func setPassword(password: String) {
        self.password = password
    }
    func getPassword() -> String {
        return self.password
    }
    func setName(name : String) {
        self.name = name
    }
    func setAge(age : Int) {
        self.age = age
    }
    func setTown(town : String) {
        self.town = town
    }
    
    func setClip() {
        
    }
    
    func setFriendsList(f : FriendsList) {
        self.friends = f
    }
    
    func setGender(g : Int) {
        self.gender = g
    }
    
    func addInstruments(i : String) {
        self.instruments.append(i)
    }
    
}