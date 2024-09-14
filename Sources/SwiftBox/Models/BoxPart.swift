//
//  Part+Corner.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//

import Foundation
import TextCore

public extension SwiftBox {

  struct BoxPart {
    public var content: MultilineString
    public var type: PartType
    
    public init(content: MultilineString, type: PartType) {
      self.content = content
      self.type = type
    }
  }
}

public extension SwiftBox.BoxPart {
  
  var width: Int {
    content.width
  }
  
  var height: Int {
    content.height
  }
  
  var columns: Int {
    self.width
  }
  
  var rows: Int {
    self.height
  }
  

}
