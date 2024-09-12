//
//  Line.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//


/// Currently this library can only handle horizontal dividers, not vertical.
/// So processing line-by-line, vertically, is fairly strightforward.
///
public extension SwiftBox {
  
  enum BoxLine {
    
    case top
    case header
    case divider
    case content
    case bottom
    
    public var isStructural: Bool {
      switch self {
        case .top, .divider, .bottom:
          true
        default:
          false
      }
    }
    
  }

  
  /// Leading and trailing line caps
  ///
//  func caps(for lineType: SwiftBox.BoxLine) -> (leading: SwiftBox.BoxGlyph, trailing: SwiftBox.BoxGlyph) {
//    switch lineType {
//        
//      case .structure(.top):
//        (
//          SwiftBox.BoxGlyph.corner(.topLeading),
//          SwiftBox.BoxGlyph.corner(.topTrailing)
//        )
//        
//      case .structure(.divider):
//        (
//          SwiftBox.BoxGlyph.join(.leading),
//          SwiftBox.BoxGlyph.join(.trailing)
//        )
//        
//      case .structure(.bottom):
//        (
//          SwiftBox.BoxGlyph.corner(.bottomLeading),
//          SwiftBox.BoxGlyph.corner(.bottomTrailing)
//        )
//        
//      case .text(.header), .text(.content):
//        (
//          SwiftBox.BoxGlyph.vertical(.exterior),
//          SwiftBox.BoxGlyph.vertical(.exterior)
//        )
//        
//    }
//  } // END caps
  
//  func cap(
//    _ end: BoxLine.Cap,
//    line: BoxLine
//  ) -> Character {
//    
//    //      var glyphCount: BoxGlyph.GlyphCount {
//    //        return config.extraFrame ? .double : .single
//    //      }
//    //
//    switch end {
//      case .leading:
//        
//        let cap = self.caps(for: line).leading
//        let leading = self.character(for: cap)
//        //        print("Leading cap: \(leading)")
//        return leading
//        
//      case .trailing:
//        
//        let cap = self.caps(for: line).trailing
//        let trailing = self.character(for: cap)
//        //        print("Leading cap: \(leading)")
//
//        return trailing
//        
//    }
//  } // END cap
}
