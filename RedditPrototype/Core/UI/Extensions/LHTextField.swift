//
//  LHTextField.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 5/4/24.
//

import UIKit

@IBDesignable
class SearchTextField: UITextField {
    enum ValueType: Int {
        case none
        case onlyLetters
        case onlyNumbers
        case phoneNumber // Allowed "+0123456789"
        case alphaNumeric
        case fullName // Allowed letters and space
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true // Asegúrate de establecer esta propiedad para que el radio de esquina se aplique correctamente
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var padding: CGFloat = 0

    var valueType = ValueType.none // Allowed characters

    /************* Added new feature ***********************/
    // Accept only given character in string, this is case sensitive
    @IBInspectable var allowedCharInString: String = ""

    func verifyFields(shouldChangeCharactersIn _: NSRange, replacementString string: String) -> Bool {
        switch valueType {
        case .none:
            break // Do nothing

        case .onlyLetters:
            let characterSet = CharacterSet.letters
            if string.rangeOfCharacter(from: characterSet.inverted) != nil {
                return false
            }

        case .onlyNumbers:
            let numberSet = CharacterSet.decimalDigits
            if string.rangeOfCharacter(from: numberSet.inverted) != nil {
                return false
            }

        case .phoneNumber:
            let phoneNumberSet = CharacterSet(charactersIn: "+0123456789")
            if string.rangeOfCharacter(from: phoneNumberSet.inverted) != nil {
                return false
            }

        case .alphaNumeric:
            let alphaNumericSet = CharacterSet.alphanumerics
            if string.rangeOfCharacter(from: alphaNumericSet.inverted) != nil {
                return false
            }

        case .fullName:
            var characterSet = CharacterSet.letters
            print(characterSet)
            characterSet = characterSet.union(CharacterSet(charactersIn: " "))
            if string.rangeOfCharacter(from: characterSet.inverted) != nil {
                return false
            }
        }

        // Check supported custom characters
        if !allowedCharInString.isEmpty {
            let customSet = CharacterSet(charactersIn: allowedCharInString)
            if string.rangeOfCharacter(from: customSet.inverted) != nil {
                return false
            }
        }

        return true
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}

