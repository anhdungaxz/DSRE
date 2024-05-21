//
//  StringExtension.swift
//  TNVN
//
//  Created by Phạm Tiến Dũng on 10/1/20.
//  Copyright © 2020 Phạm Tiến Dũng. All rights reserved.
//

import Foundation
import UIKit

enum GeneratorType {
  case qrCode, barCode, aztecCode
  
  var filterName: String {
    switch self {
    case .aztecCode:
      return "CIAztecCodeGenerator"
    case .barCode:
      return "CICode128BarcodeGenerator"
    case .qrCode:
      return "CIQRCodeGenerator"
    }
  }
}

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var convert0to84: String {
        
        if self == "" {
            
            return self
        }
        if self.count < 1 {
            
            return self
            
        }
        let firstIndex = self.index((self.startIndex), offsetBy: 1)
        let first = String(self[..<firstIndex])
        if first == "0" {
            let mob = String(String(describing: self.suffix(from: firstIndex)))
            return "84\(mob)"
        }
        return self
        
    }
    var convert84to0: String {
        
        if self == "" {
            
            return self
        }
        if self.count < 2 {
            
            return self
            
        }
        let firstIndex = self.index((self.startIndex), offsetBy: 2)
        let first = String(self[..<firstIndex])
        if first == "84" {
            let mob = String(String(describing: self.suffix(from: firstIndex))).removingWhitespaces()
            return "0\(mob)"
        }
        return self
        
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func generateCode(type: GeneratorType = .qrCode,
                      transform: CGAffineTransform = CGAffineTransform(scaleX: 32.0, y: 32.0),
                      fillColor: UIColor = UIColor.black,
                      backgroundColor: CIColor = CIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)) -> UIImage? {
          guard let filter = CIFilter(name: type.filterName) else {
            return nil
          }
          
          filter.setDefaults()
          
          guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
          }
          
          filter.setValue(data, forKey: "inputMessage")
          
          let filterFalseColor = CIFilter(name: "CIFalseColor")
          filterFalseColor?.setDefaults()
          filterFalseColor?.setValue(filter.outputImage, forKey: "inputImage")
          filterFalseColor?.setValue(CIColor(cgColor: fillColor.cgColor), forKey: "inputColor0")
          filterFalseColor?.setValue(backgroundColor, forKey: "inputColor1")
          
          
          guard let image = filterFalseColor?.outputImage else { return nil }
          
          return UIImage(ciImage: image.transformed(by: transform), scale: 1.0,
                         orientation: UIImage.Orientation.up)
    }

    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    func isEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func numberOfLinesForString(size: CGSize, font: UIFont) -> Int {
        let textStorage = NSTextStorage(string: self, attributes: [NSAttributedString.Key.font: font])

        let textContainer = NSTextContainer(size: size)
        textContainer.lineBreakMode = .byWordWrapping
        textContainer.maximumNumberOfLines = 0
        textContainer.lineFragmentPadding = 0

        let layoutManager = NSLayoutManager()
        layoutManager.textStorage = textStorage
        layoutManager.addTextContainer(textContainer)

        var numberOfLines = 0
        var index = 0
        var lineRange : NSRange = NSMakeRange(0, 0)
        for i in 0...layoutManager.numberOfGlyphs {
            layoutManager.lineFragmentRect(forGlyphAt: i, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }

        return numberOfLines
    }
    
    func convertDateSmart() -> Date? {
        if let date = self.toDate() {
            return date
        } else {
            return self.toDate(formater: "dd/MM/yyyy")
        }
    }
    
    func toDate(formater: String = "dd/MM/yyyy HH:mm:ss") -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formater
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
    
    func stringFromHTML(font: UIFont? = nil) -> NSAttributedString? {
        var attributedText: NSAttributedString?
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        if let data = data(using: .unicode, allowLossyConversion: true), let attrStr = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            attributedText = attrStr
        }
        
        if let font = font, let attr = attributedText {
            let newAttributedString = NSMutableAttributedString(attributedString: attr)

            // Enumerate through all the font ranges
            newAttributedString.enumerateAttribute(NSAttributedString.Key.font, in: NSMakeRange(0, newAttributedString.length), options: [])
            {
                value, range, stop in
                guard let currentFont = value as? UIFont else {
                    return
                }

                // An NSFontDescriptor describes the attributes of a font: family name, face name, point size, etc.
                // Here we describe the replacement font as coming from the "Hoefler Text" family
                let fontDescriptor = currentFont.fontDescriptor

                // Ask the OS for an actual font that most closely matches the description above
                if let newFontDescriptor = fontDescriptor.matchingFontDescriptors(withMandatoryKeys: [UIFontDescriptor.AttributeName.family]).first {
                    let newFont = UIFont(descriptor: newFontDescriptor, size: font.pointSize)
                    newAttributedString.addAttributes([NSAttributedString.Key.font: newFont], range: range)
                }
            }
            return newAttributedString
        }
        
        return attributedText
    }
    
    func toJson() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if let json = json {
                return json
            }
        }
        return nil
    }
    
    enum EnumImagePosiotion {
        case prefix
        case suffix
    }
    
    func insertImage(_ image: UIImage, offsetY: CGFloat = 0, position: EnumImagePosiotion = .prefix) -> NSAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        // Set bound to reposition
        imageAttachment.bounds = CGRect(x: 0, y: offsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        
        if position == .prefix {
            completeText.append(attachmentString)
            let text = NSAttributedString(string: " " + self)
            completeText.append(text)
        } else {
            
            let text = NSAttributedString(string:self + " ")
            completeText.append(text)
            completeText.append(attachmentString)
        }
        
        
        return completeText
    }
    
    var isValidPhoneNumber: Bool {

        let validCount = count == 10
        let startWithZero = first == "0"
        return isDigits && validCount && startWithZero
    }
    
    var isValidMSISDN: Bool {
        if self.prefix(2) == "84" {
            let validCount = count == 11
            return isDigits && validCount
        } else if self.prefix(1) == "0" {
            let validCount = count == 10
            return isDigits && validCount
        }
        return false
    }
    
    var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    func removeDiacritics() -> String{
        var pattern = self.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
        pattern = pattern.replacingOccurrences(of: "đ", with: "d")
        
        return pattern
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}

