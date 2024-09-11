//
//  Part+Corner.swift
//  SwiftBox
//
//  Created by Dave Coleman on 11/9/2024.
//

public extension SwiftBox.BoxPart {
  
  enum Corner: Hashable {
    /// ┏
    case topLeading
    /// ┓
    case topTrailing
    /// ┗
    case bottomLeading
    /// ┛
    case bottomTrailing
    
  }
}

public extension SwiftBox {
  
  func partPreset(
    for part: SwiftBox.BoxPart,
    with mode: SwiftBox.BoxPart.PartMode
  ) -> String {
    
    switch part {
      case .corner(let cornerType):
        
        var result = ""
        
        switch mode {
          case .oneByOne:
            break
            
          case .threeByTwo:
            
            switch cornerType {
              case .topLeading:
                var result: String = ""
                
                /// 3x2 — Top row
                result += character(for: .corner(.topLeading)).string
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .horizontal(.exterior)).string
                result += "\n"
                
                /// 3x2 — Bottom row
                result += character(for: .vertical(.exterior)).string
                result += " "
                result += character(for: .corner(.topLeading)).string

                return result
                
              case .topTrailing:
                var result: String = ""
                
                /// 3x2 — Top row
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .corner(.topTrailing)).string
                result += "\n"
                
                /// 3x2 — Bottom row
                result += character(for: .corner(.topTrailing)).string
                result += " "
                result += character(for: .vertical(.exterior)).string
                
                return result
                
                
              case .bottomLeading:
                var result: String = ""
                
                /// 3x2 — Top row
                result += character(for: .vertical(.exterior)).string
                result += " "
                result += character(for: .corner(.bottomLeading)).string
                result += "\n"
                
                /// 3x2 — Bottom row
                result += character(for: .corner(.bottomLeading)).string
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .horizontal(.exterior)).string
                
                return result
                
                
              case .bottomTrailing:
                var result: String = ""
                
                /// 3x2 — Top row
                result += character(for: .corner(.bottomTrailing)).string
                result += " "
                result += character(for: .vertical(.exterior)).string
                result += "\n"
                
                /// 3x2 — Bottom row
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .horizontal(.exterior)).string
                result += character(for: .corner(.bottomTrailing)).string
                
                return result


            }
            
        }
        
        return result
        
      case .horizontal:
        
        var result = ""
        
        switch mode {
          case .oneByOne:
            break
            
          case .threeByTwo:
            
            result += character(for: .horizontal(location)).string
            result += "\n"
            result += character(for: .horizontal(location)).string
            
            
                
            }
            
        
        return result
        
        
        
        
      case .join(let join):
        return ""
      case .vertical(let location):
        return ""
    }
    
  }
}
