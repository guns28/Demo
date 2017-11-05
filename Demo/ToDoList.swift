//
//  ToDoList.swift
//  Demo
//
//  Created by Ahmed Karmous on 04/11/2017.
//  Copyright © 2017 Ahmed Karmous. All rights reserved.
//

import RealmSwift

class ToDoList: Object {

    dynamic var name = ""
    dynamic var date = Date()
    let tasks = List<ToDo>()

}
