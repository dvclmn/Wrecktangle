//
//  Part+Corner.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//

import Foundation
import TextCore

public extension SwiftBox {
  
  typealias CharacterGrid = [[Character]]
  
  struct BoxPart {
    public var content: CharacterGrid
    public var type: PartType
    
//    @available(*, deprecated, message: "Use `SwiftBox.part(_:)` to create parts.")
    public init(content: CharacterGrid, type: PartType) {
      self.content = content
      self.type = type
    }
  }
}

public extension SwiftBox.BoxPart {
  
  var width: Int {
    content.first?.count ?? 0
  }
  
  var height: Int {
    content.count
  }
  
  var columns: Int {
    self.width
  }
  
  var rows: Int {
    self.height
  }
  

}
