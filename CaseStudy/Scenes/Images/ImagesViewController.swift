//
//  ViewController.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 11.05.2021.
//

import UIKit
import UIScrollView_InfiniteScroll

private struct Constants {
    static let contentInsetsForTableView = UIEdgeInsets(top: 10.0, left: .zero, bottom: 10.0, right: .zero)
}

public protocol ImagesViewProtocol: AnyObject {
    func deleteRow(at indexPath: IndexPath)
    func endRefreshing()
    func prepareTableView()
    func prepareAddBarButton()
    func reloadTableView()
    func setTableViewVisibility(isHidden: Bool)
    func setTitle(with title: String)
    func refresh()
}

public final class ImagesViewController: UIViewController, ViewController {
    
    public static var storyboardName: UIStoryboard.Name = .main
    
    @IBOutlet private weak var tableView: UITableView!
    
    public var presenter: ImagesPresenterProtocol!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @objc private func addButtonDidTap() {
        presenter.addBarButtonDidTap()
    }
}

// MARK: - ImagesViewProtocol

extension ImagesViewController: ImagesViewProtocol {
    
    public func endRefreshing() {
        tableView.endRefreshing()
    }
    
    public func deleteRow(at indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.endUpdates()
    }
    
    public func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: ImageCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: ImageCell.self))
        tableView.contentInset = Constants.contentInsetsForTableView
        tableView.addRefresher(selector: #selector(refresh))
        
        tableView.addInfiniteScroll { [unowned self] _ in
            self.presenter.next()
            tableView.finishInfiniteScroll()
        }
        
        tableView.setShouldShowInfiniteScrollHandler { [unowned self] _ -> Bool in
            return presenter.hasNextPage
        }
    }
    
    public func prepareAddBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonDidTap))
    }
    
    @objc public func refresh() {
        presenter.refresh()
    }
    
    public func reloadTableView() {
        tableView.reloadData()
    }
    
    public func setTableViewVisibility(isHidden: Bool) {
        tableView.isHidden = isHidden
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
    
    public func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.delete(at: indexPath)
        }
    }
}

// MARK: - UITableViewDelegate

extension ImagesViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Refresh Control

public extension UIScrollView {
    
    func addRefresher(color: UIColor = .lightGray, selector: Selector) {
        
        let refresher = UIRefreshControl()
        refresher.tintColor = color
        refresher.addTarget(nil, action: selector, for: .valueChanged)
        refreshControl = refresher
    }
    
    func endRefreshing() {
        refreshControl?.endRefreshing()
    }
}
