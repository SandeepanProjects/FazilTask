//
//  PhotoOperations.swift
//  PeopleTenTask
//
//  Created by Sandeepan Swain on 13/05/20.
//  Copyright © 2020 Sandeepan Swain. All rights reserved.
//

import Foundation
import UIKit


enum PetRecordState {
    case new, downloaded, filtered, failed
}

public class PendingOperations {
    
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    lazy var filtrationsInProgress: [IndexPath: Operation] = [:]
    lazy var filtrationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Image Filtration queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

public class ImageDownloader: Operation {
    
    private var photoRecord: Image
    
    init(_ photoRecord: Image) {
        self.photoRecord = photoRecord
    }
    
    override public func main() {
        
        if isCancelled {
            return
        }
        
        if let postURL = URL(string: photoRecord.url ?? "")
        {
            guard let imageData = try? Data(contentsOf: postURL) else { return }
            
            if isCancelled {
                return
            }
            
            if !imageData.isEmpty {
                photoRecord.imageSet = UIImage(data:imageData)
                photoRecord.state = .downloaded
            } else {
                photoRecord.state = .failed
                photoRecord.imageSet = UIImage(named: "Failed")
            }
        }
    }
}

public class ImageFilteration: Operation {
    private var photoRecord: Image

    init(_ photoRecord: Image) {
        self.photoRecord = photoRecord
    }

    override public func main () {
        if isCancelled {
            return
        }

        guard self.photoRecord.state == .downloaded else {
            return
        }

        if let image = photoRecord.imageSet,
            let filteredImage = applySepiaFilter(image) {
            photoRecord.imageSet = filteredImage
            photoRecord.state = .filtered
        }
    }

    func applySepiaFilter(_ image: UIImage) -> UIImage? {
        guard let data = image.pngData() else { return nil }
        let inputImage = CIImage(data: data)

        if isCancelled {
            return nil
        }

        let context = CIContext(options: nil)

        guard let filter = CIFilter(name: Strings.sepiaTone.rawValue) else { return nil }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(0.8, forKey: Strings.inputIntensity.rawValue)

        if isCancelled {
            return nil
        }

        guard let outputImage = filter.outputImage,
            let outImage = context.createCGImage(outputImage, from: outputImage.extent)
            else {
                return nil
        }
        return UIImage(cgImage: outImage)
    }
}
