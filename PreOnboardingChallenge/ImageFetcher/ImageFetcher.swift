//
//  ImageFetcher.swift
//  PreOnboardingChallenge
//
//  Created by apple on 2023/02/19.
//

import UIKit

final class ImageFetcher {
    private static let url = URL(string: "https://picsum.photos/1080/620")!

    private static let dispatchQueue = DispatchQueue(
        label: "jeongyeob.PreOnboardingChallenge.ImageFetcherDispatchQueue",
        qos: .utility,
        attributes: .concurrent
    )

    private static let operationQueue: OperationQueue = OperationQueue().then {
        $0.name = "jeongyeob.PreOnboardingChallenge.ImageFetcherOperationQueue"
      }

    static func fetchImage(
        urlString: String,
        completionHandler: @escaping (UIImage?) -> Void
    ) {
        guard let url = URL(string: "https://picsum.photos/1080/620") else {
            completionHandler(nil)
            return

        }
//        dispatchQueue.async {
//            if let data = try? Data(contentsOf: url),
//               let image = UIImage(data: data) {
//                completionHandler(image)
//                return
//            }
//            completionHandler(nil)
//        }

        operationQueue.addOperation {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                completionHandler(image)
                return
            }
            completionHandler(nil)
        }
    }
}
