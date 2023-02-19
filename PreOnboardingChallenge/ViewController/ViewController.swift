//
//  ViewController.swift
//  PreOnboardingChallenge
//
//  Created by apple on 2023/02/19.
//

import UIKit

import Then
import SnapKit

protocol LoadButtonAction: AnyObject {
    func buttonTapped(with tag: Int)
}

final class ViewController: UIViewController {

    private let imageLoadRowViews: [ImageLoadRowView] = {
        var array: [ImageLoadRowView] = []
        for i in (0..<5) {
            let imageLoadRowView = ImageLoadRowView()
            imageLoadRowView.tag = i
            array.append(imageLoadRowView)
        }
        return array
    }()

    private lazy var reloadAllButton = UIButton().then {
        $0.setTitle("Load All Iamges", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = .tintColor
        $0.layer.cornerRadius = 5

        $0.addTarget(self, action: #selector(reloadAllButtonTapped(_:)), for: .touchUpInside)
    }

    @objc
    private func reloadAllButtonTapped(_ button: UIButton) {
        imageLoadRowViews.forEach { imageLoadRowView in
            imageLoadRowView.setPlaceHolder()
            ImageFetcher.fetchImage(urlString: "https://picsum.photos/1080/620") { image in
                DispatchQueue.main.async {
                    imageLoadRowView.update(image: image)
                }
            }
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func render() {

        let stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 20
        }

        view.addSubview(stackView)

        for imageLoadRowView in imageLoadRowViews {
            imageLoadRowView.delegate = self
            stackView.addArrangedSubview(imageLoadRowView)
        }

        reloadAllButton.snp.makeConstraints {
            $0.height.equalTo(36)
        }

        stackView.addArrangedSubview(reloadAllButton)

        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

    }

}

extension ViewController: LoadButtonAction {
    func buttonTapped(with tag: Int) {
        imageLoadRowViews[tag].setPlaceHolder()
        ImageFetcher.fetchImage(urlString: "https://picsum.photos/1080/620") { image in
            DispatchQueue.main.async { [weak self] in
                self?.imageLoadRowViews[tag].update(image: image)
            }
        }
    }
}
