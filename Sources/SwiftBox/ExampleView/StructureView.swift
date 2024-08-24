//
//  Structure.swift
//  SwiftBox
//
//  Created by Dave Coleman on 24/8/2024.
//

import SwiftUI

struct StructureView: View {
  
  var body: some View {
    
    VStack{
      Text(Self.singleBox)
      Text(Self.singleBox)
    }
    .monospaced()
    .textSelection(.enabled)
    .padding(40)
    .frame(width: 600, height: 700)
    .background(.black.opacity(0.6))
    
  }
}
#Preview {
  StructureView()
}

extension StructureView {
  static let singleBox: String = """
  ┏━━━━━━━┓
  ┃       ┃
  ┃       ┃
  ┃       ┃
  ┗━━━━━━━┛
  """
}


