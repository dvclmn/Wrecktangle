//
//  BoxLine+Structural.swift
//  SwiftBox
//
//  Created by Dave Coleman on 13/9/2024.
//



public extension SwiftBox {

  struct StructuralContent: LineContent {
    public let rawContent: String
    public let type: LineType = .structural
    let repeatingPattern: BoxPart
    
    init(repeatingPattern: BoxPart) {
      self.repeatingPattern = repeatingPattern
      self.rawContent = repeatingPattern.content.map { String($0) }.joined(separator: "\n")
    }
    
    func render(width: Int, trimMethod: TrimMethod = .leaveSpace) -> [[Character]] {
      return SwiftBox.repeatHorizontally(
        repeatingPattern,
        toWidth: width,
        trimMethod: trimMethod
      )
    }
  }


}
