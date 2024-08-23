//
//  Configuration.swift
//  SwiftBox
//
//  Created by Dave Coleman on 23/8/2024.
//

extension SwiftBox {
  
  /// A structure that defines the appearance and behavior of a `SwiftBox`.
  ///
  /// Use `Configuration` to customize various aspects of a `SwiftBox`,
  /// such as its theme, width, and content limitations.
  ///
  ///
  public struct Configuration {


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
    
    
    /// A boolean value that determines whether to display metrics about the box.
    ///
    /// When `true`, information such as character count and line count will be shown.
    ///
    public var metrics: Metrics
    
    public var extraFrame: Bool
    
    public init(
      theme: Theme = Theme(),
      width: Int = 60,
      headerLineLimit: Int? = 3,
      contentLineLimit: Int? = nil,
      metrics: Metrics = Metrics(),
      extraFrame: Bool = false
    ) {
      self.theme = theme
      self.width = width
      self.headerLineLimit = headerLineLimit
      self.contentLineLimit = contentLineLimit
      self.metrics = metrics
      self.extraFrame = extraFrame
    }
    
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

    /// The default configuration for a `SwiftBox`.
    ///
    public static let `default` = Config()
  }




}
