//
//  BookSingleView.swift
//  App
//
//  Created by Ivan on 07.05.2021.
//

import UIKit

final class BookSingleView : UILabel {
    
    func setup(with text: String,
               description: String) {
        numberOfLines = 0
        let desc = description + ": "
        showText(desc + text)
        showDescription(desc)
    }
    
    func showText(_ text: String) {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraph,
            .font: UIFont.systemFont(ofSize: 18, weight: .medium),
            .foregroundColor: UIColor.label
        ]
        
        attributedText = NSMutableAttributedString(string: text, attributes: textAttributes)
    }
    
    func showDescription(_ description: String) {
        
        let descriptionAttributes: [NSAttributedString.Key: Any] =
            [.font: UIFont.systemFont(ofSize: 18, weight: .regular),
                 .foregroundColor: UIColor.secondaryLabel]
        
        guard let text = attributedText?.string,
              let attributedText = attributedText,
              text.contains(description) else {
            return
        }
        
        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        attributedString.addAttributes(descriptionAttributes, range: text.range(by: description))
        
        self.attributedText = attributedString
    }
}

extension String {
    
    func range(by substring: String) -> NSRange {
        
        let substringRange = range(of: substring)!
        return NSRange(substringRange, in: self)
    }
    
    var nsRange: NSRange {
        
        let substringRange = range(of: self)!
        return NSRange(substringRange, in: self)
    }
    
    subscript (range: Range<Int>) -> String {
        
        let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
