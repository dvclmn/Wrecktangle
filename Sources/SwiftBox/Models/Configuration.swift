//
//  Configuration.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

public extension SwiftBox {
  
  /// A structure that defines the appearance and behavior of a `SwiftBox`.
  ///
  /// Use `Config` to customize various aspects of a `SwiftBox`,
  /// such as its theme, width, and content limitations.
  ///
  ///
  struct Config {

    /// The visual theme of the box.
    ///
    public var theme: Theme
    
    /// The width of the box in characters.
    ///
    /// This value determines the overall width of the box, including its borders.
    /// The content will be wrapped to fit within this width.
    ///
    public var width: Int
    
    /// The maximum number of lines for the header.
    ///
    /// If set, the header will be truncated if it exceeds this number of lines.
    /// Set to `nil` for no limit.
    ///
    public var headerLineLimit: Int?
    
    /// The maximum number of lines for the main content.
    ///
    /// If set, the content will be truncated if it exceeds this number of lines.
    /// Set to `nil` for no limit.
    ///
    public var contentLineLimit: Int?
    
    /// Display metadata about the box itself
    ///
    public var metrics: Metrics
    
    public init(
      theme: Theme = Theme(),
      width: Int = 60,
      headerLineLimit: Int? = 3,
      contentLineLimit: Int? = nil,
      metrics: Metrics = Metrics()
    ) {
      self.theme = theme
      self.width = width
      self.headerLineLimit = headerLineLimit
      self.contentLineLimit = contentLineLimit
      self.metrics = metrics
    }
    

    /// The default configuration for a `SwiftBox`.
    ///
    public static let `default` = Config()
  }

}
