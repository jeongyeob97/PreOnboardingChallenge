//
//  ImageFetcher.swift
//  PreOnboardingChallenge
//
//  Created by apple on 2023/02/19.
//

import UIKit

final class ImageFetcher {
    private static let url = URL(string: "https://picsum.photos/1080/620")!

    private static let queue = DispatchQueue(
        label: "jeongyeob.PreOnboardingChallenge.ImageFetcherQueue",
        qos: .utility,
        attributes: .concurrent
    )

    static func fetchImage(
        urlString: String,
        completionHandler: @escaping (UIImage?) -> Void
    ) {
        guard let url = URL(string: "https://picsum.photos/1080/620") else {
            completionHandler(nil)
            return

        }
        queue.async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                completionHandler(image)
                return
            }
            completionHandler(nil)
        }
    }
}
