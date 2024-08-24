//
//  Metrics.swift
//  SwiftBox
//
//  Created by Dave Coleman on 24/8/2024.
//

extension SwiftBox.Configuration {
  
  public struct Metrics {
    var widthCounter: WidthCounterStyle
    var lineNumbers: Bool
    var invisibles: Bool
    
    public init(
      widthCounter: WidthCounterStyle = .off,
      lineNumbers: Bool = false,
      invisibles: Bool = false
    ) {
      self.widthCounter = widthCounter
      self.lineNumbers = lineNumbers
      self.invisibles = invisibles
    }
    
    public enum WidthCounterStyle {
      case off
      case compact
      case full
    }
  }
}
