//
//  ViewController.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit

private struct Constants {
    static let contentInsetsForTableView = UIEdgeInsets(top: 10.0, left: .zero, bottom: 10.0, right: .zero)
}

public protocol ImagesViewProtocol: AnyObject {
    func setTitle(with title: String)
    func prepareTableView()
    func reloadTableView()
}

public final class ImagesViewController: UIViewController, ViewController {
    
    public static var storyboardName: UIStoryboard.Name = .main
    
    @IBOutlet private weak var tableView: UITableView!
    
    public var presenter: ImagesPresenterProtocol!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - ImagesViewProtocol

extension ImagesViewController: ImagesViewProtocol {
    public func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: ImageCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: ImageCell.self))
        tableView.contentInset = Constants.contentInsetsForTableView
    }
    
    public func reloadTableView() {
        tableView.reloadData()
    }
    
    public func setTitle(with title: String) {
        self.title = title
    }
}

// MARK: - UITableViewDataSource

extension ImagesViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImageCell.self),
                                                       for: indexPath) as? ImageCell else {
            return .init()
        }
        let imagePresentation = presenter.image(at: indexPath)
        let cellPresenter = ImageCellPresenter(view: cell, imagePresentation: imagePresentation)
        cell.presenter = cellPresenter
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ImagesViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
