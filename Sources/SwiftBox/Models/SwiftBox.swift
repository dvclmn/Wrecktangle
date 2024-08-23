//
//  Models.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

import Foundation

public typealias Theme = SwiftBox.Theme
public typealias Config = SwiftBox.Configuration
public typealias Part = SwiftBox.FramePart
public typealias Line = SwiftBox.BoxLine
public typealias GlyphStyle = SwiftBox.Theme.GlyphStyle


public struct SwiftBox {
  
  var header: String
  var content: String
  var config: Config
  
  var attributedString: AttributedString {
    return self.drawBox()
  }
  
  public init(
    header: String,
    content: String,
    config: Config = .init()
  ) {
    self.header = header
    self.content = content
    self.config = config
  }
  
  /// Currently this implementaiton can only handle horizontal dividers, not vertical.
  /// So we can process line-by-line vertically in a fairly straightforward way.
  ///
  public enum BoxLine {
    case top
    case header
    case divider
    case content
    case bottom
    
    /// Leading and trailing line caps
    ///
    public var caps: (Part, Part) {
      switch self {
        case .top:
          (
            Part.corner(.top(.leading)),
            Part.corner(.top(.trailing))
          )
          
        case .header, .content:
          (
            Part.vertical(.exterior),
            Part.vertical(.exterior)
          )
          
        case .divider:
          (
            Part.join(.leading),
            Part.join(.trailing)
          )
          
        case .bottom:
          (
            Part.corner(.bottom(.leading)),
            Part.corner(.bottom(.trailing))
          )
          
      }
    } // END caps
    
    public func repeatableString(for config: Config) -> String {
      
      let horizontalExterior: String = Part.horizontal(.exterior).character(with: config).asString
      
      let horizontalInterior: String = Part.horizontal(.interior).character(with: config).asString

      switch self {
        case .top:
          return horizontalExterior
        case .header, .content:
          return ""
        case .divider:
          return horizontalInterior

        case .bottom:
          return horizontalExterior
      }
    }
    
    public enum CapEnd {
      case leading
      case trailing
    }
    
    public func cap(
      _ end: CapEnd,
      with config: Config
    ) -> AttributedString {
      
      var glyphCount: Part.GlyphCount {
        return config.extraFrame ? .double : .single
      }
      
      let container = config.theme.styles.secondary.container
      switch end {
        case .leading:
          return self.caps.0.character(with: config, count: glyphCount, container: container)
        case .trailing:
          return self.caps.1.character(with: config, count: glyphCount, container: container)

      }
    } // END cap
  }
  
  

  
}
