//
//  MockImagesView.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 11.05.2021.
//

import CaseStudy
import UIKit

public final class MockImagesView: ImagesViewProtocol {

    var invokedDeleteRow = false
    var invokedDeleteRowCount = 0
    var invokedDeleteRowParameters: (indexPath: IndexPath, Void)?
    var invokedDeleteRowParametersList = [(indexPath: IndexPath, Void)]()

    public func deleteRow(at indexPath: IndexPath) {
        invokedDeleteRow = true
        invokedDeleteRowCount += 1
        invokedDeleteRowParameters = (indexPath, ())
        invokedDeleteRowParametersList.append((indexPath, ()))
    }

    var invokedEndRefreshing = false
    var invokedEndRefreshingCount = 0

    public func endRefreshing() {
        invokedEndRefreshing = true
        invokedEndRefreshingCount += 1
    }

    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0

    public func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }

    var invokedPrepareAddBarButton = false
    var invokedPrepareAddBarButtonCount = 0

    public func prepareAddBarButton() {
        invokedPrepareAddBarButton = true
        invokedPrepareAddBarButtonCount += 1
    }

    var invokedReloadTableView = false
    var invokedReloadTableViewCount = 0

    public func reloadTableView() {
        invokedReloadTableView = true
        invokedReloadTableViewCount += 1
    }

    var invokedSetTableViewVisibility = false
    var invokedSetTableViewVisibilityCount = 0
    var invokedSetTableViewVisibilityParameters: (isHidden: Bool, Void)?
    var invokedSetTableViewVisibilityParametersList = [(isHidden: Bool, Void)]()

    public func setTableViewVisibility(isHidden: Bool) {
        invokedSetTableViewVisibility = true
        invokedSetTableViewVisibilityCount += 1
        invokedSetTableViewVisibilityParameters = (isHidden, ())
        invokedSetTableViewVisibilityParametersList.append((isHidden, ()))
    }

    var invokedSetTitle = false
    var invokedSetTitleCount = 0
    var invokedSetTitleParameters: (title: String, Void)?
    var invokedSetTitleParametersList = [(title: String, Void)]()

    public func setTitle(with title: String) {
        invokedSetTitle = true
        invokedSetTitleCount += 1
        invokedSetTitleParameters = (title, ())
        invokedSetTitleParametersList.append((title, ()))
    }

    var invokedRefresh = false
    var invokedRefreshCount = 0

    public func refresh() {
        invokedRefresh = true
        invokedRefreshCount += 1
    }
}
