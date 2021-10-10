//
//  CakeDetailViewController.swift
//  CakeApp
//
//  Created by Mikael Galliot on 10/10/2021.
//

import UIKit
import Combine


class CakeDetailViewController: UIViewController {
    
    @IBOutlet private weak var cakeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    let viewModel:CakeDetailsViewModel
    
    init?(viewModel:CakeDetailsViewModel, coder: NSCoder)  {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(viewModel:coder:)")
    required init?(coder: NSCoder) {
        fatalError("Invalid way of decoding this class")
    }
    
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = viewModel.cakeDetails.title
        descriptionLabel.text = viewModel.cakeDetails.desc
        
        cancellable = loadImage(for: viewModel.cakeDetails.image).sink { [unowned self] image in
            self.cakeImageView.image = image
            
        }
    }
    deinit {
        cancellable?.cancel()
    }
    
    private func loadImage(for urlStr: String) -> AnyPublisher<UIImage?, Never> {
        return Just(urlStr)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: urlStr)!
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
}

