//
//  UIImageView+RT.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import SDWebImage

extension UIImage {
    func setImageJPEGValueBase64() -> String? {
         jpegData(compressionQuality: JPEGQuality.low.rawValue)?.base64EncodedString()
    }
    
    func setImagePNGValueBase64() -> String? {
        pngData()?.base64EncodedString()
    }
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension UIImageView {
    func setImage(urlString: String?) {
        guard let urlString = urlString, !urlString.isEmpty, let imageURL = URL(string: urlString) else {
            self.image = nil // Si la URL es nula o vacía, limpiamos la imagen
            return
        }
        
        // Forzar la recarga de la imagen
        let uniqueURLString = "\(urlString)?\(UUID().uuidString)"
        guard let uniqueImageURL = URL(string: uniqueURLString) else {
            self.image = nil
            return
        }
        
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: uniqueImageURL, placeholderImage: nil, options: [], completed: nil)
    }
    
    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = tintedImage
        self.tintColor = color
    }
}

// Limpiar la caché de SDWebImage
func clearSDWebImageCache() {
    SDImageCache.shared.clearMemory()
    SDImageCache.shared.clearDisk()
}

// Vaciar la caché de SDWebImage
// clearSDWebImageCache()

