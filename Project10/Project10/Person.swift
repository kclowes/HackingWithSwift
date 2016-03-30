//
//  Person.swift
//  Project10
//
//  Created by Keri Clowes on 3/30/16.
//  Copyright © 2016 Keri Clowes. All rights reserved.
//

import UIKit

class Person: NSObject {
  var name: String
  var image: String

  init(name: String, image: String) {
    self.name = name
    self.image = image
  }
}
