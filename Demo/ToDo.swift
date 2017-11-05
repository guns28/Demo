//
//  ToDo.swift
//  Demo
//
//  Created by Ahmed Karmous on 04/11/2017.
//  Copyright © 2017 Ahmed Karmous. All rights reserved.
//

import RealmSwift


class ToDo: Object {

    dynamic var name = ""
    dynamic var createdAt = NSDate()
    dynamic var notes = ""
    dynamic var isCompleted = false
    dynamic var priority = 0
    
}
