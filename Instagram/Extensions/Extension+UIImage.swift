//
//  Extension+UIImage.swift
//  Instagram
//
//  Created by Jung Choi on 8/21/23.
//

import AVFoundation
import UIKit

extension UIImage {
    func resized(width: Int, height: Int) -> UIImage {
        let maxSize = CGSize(width: width, height: height)

        let availableRect = AVFoundation.AVMakeRect(aspectRatio: self.size, insideRect: .init(origin: .zero, size: maxSize))
        let targetSize = availableRect.size

        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)

        let resized = renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return resized
    }
}
