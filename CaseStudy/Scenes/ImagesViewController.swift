//
//  ViewController.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit

private struct Constants {
    static let title = "Images"
}

public protocol ImagesViewProtocol: AnyObject {
    func prepareNavigationBar()
}

public final class ImagesViewController: UIViewController, ViewController {
    
    public static var storyboardName: UIStoryboard.Name = .main
    
    public var presenter: ImagesPresenterProtocol!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - ImagesViewProtocol

extension ImagesViewController: ImagesViewProtocol {
    
    public func prepareNavigationBar() {
        title = Constants.title
    }
}
