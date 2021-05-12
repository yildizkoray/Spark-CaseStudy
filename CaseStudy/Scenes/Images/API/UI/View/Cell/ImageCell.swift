//
//  ImageCell.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import UIKit
import AlamofireImage

private struct Constants {
    static let titleFontSize: CGFloat =  16
    static let descriptionFontSize: CGFloat = 14
}

public protocol ImageCellProtocol: AnyObject {
    func prepareUI()
    func configure(with presentation: ImagePresentation)
}

public final class ImageCell: UITableViewCell {
    
    @IBOutlet private weak var imageImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    
    public var presenter: ImageCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
}

// MARK: - ImageCellProtocol
extension ImageCell: ImageCellProtocol {
    
    public func configure(with presentation: ImagePresentation) {
        titleLabel.text = presentation.title
        descriptionLabel.text = presentation.description
        imageImageView.af.setImage(withURL: presentation.url)
    }
    
    public func prepareUI() {
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize, weight: .regular)
    }
}


