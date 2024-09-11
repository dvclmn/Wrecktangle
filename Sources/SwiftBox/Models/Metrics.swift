//
//  Metrics.swift
//  SwiftBox
//
//  Created by Dave Coleman on 24/8/2024.
//

import TextCore

public extension SwiftBox.Config {
  
  struct Metrics {
    var widthCounter: TextCore.WidthCounterStyle
    var lineNumbers: Bool
    var invisibles: Bool
    
    public init(
      widthCounter: TextCore.WidthCounterStyle = .off,
      lineNumbers: Bool = false,
      invisibles: Bool = false
    ) {
      self.widthCounter = widthCounter
      self.lineNumbers = lineNumbers
      self.invisibles = invisibles
    }

  }
}
