//
//  MockImageRouter.swift
//  CaseStudyTests
//
//  Created by Koray Yıldız on 14.05.2021.
//

import CaseStudy
import UIKit

public final class MockImageView: ImageViewProtocol {
    
    var invokedPrepareUI = false
    var invokedPrepareUICount = 0
    
    public func prepareUI() {
        invokedPrepareUI = true
        invokedPrepareUICount += 1
    }
    
    var invokedPrepareUpdateBarButton = false
    var invokedPrepareUpdateBarButtonCount = 0
    
    public func prepareUpdateBarButton() {
        invokedPrepareUpdateBarButton = true
        invokedPrepareUpdateBarButtonCount += 1
    }
    
    var invokedPrepareSaveBarButton = false
    var invokedPrepareSaveBarButtonCount = 0
    
    public func prepareSaveBarButton() {
        invokedPrepareSaveBarButton = true
        invokedPrepareSaveBarButtonCount += 1
    }
    
    var invokedPrepareImagePicker = false
    var invokedPrepareImagePickerCount = 0
    
    public func prepareImagePicker() {
        invokedPrepareImagePicker = true
        invokedPrepareImagePickerCount += 1
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
    
    var invokedSetTitleTextFieldText = false
    var invokedSetTitleTextFieldTextCount = 0
    var invokedSetTitleTextFieldTextParameters: (text: String, Void)?
    var invokedSetTitleTextFieldTextParametersList = [(text: String, Void)]()
    
    public func setTitleTextFieldText(text: String) {
        invokedSetTitleTextFieldText = true
        invokedSetTitleTextFieldTextCount += 1
        invokedSetTitleTextFieldTextParameters = (text, ())
        invokedSetTitleTextFieldTextParametersList.append((text, ()))
    }
    
    var invokedSetDescriptionTextViewText = false
    var invokedSetDescriptionTextViewTextCount = 0
    var invokedSetDescriptionTextViewTextParameters: (text: String, Void)?
    var invokedSetDescriptionTextViewTextParametersList = [(text: String, Void)]()
    
    public func setDescriptionTextViewText(text: String) {
        invokedSetDescriptionTextViewText = true
        invokedSetDescriptionTextViewTextCount += 1
        invokedSetDescriptionTextViewTextParameters = (text, ())
        invokedSetDescriptionTextViewTextParametersList.append((text, ()))
    }
    
    var invokedSetImageViewImage = false
    var invokedSetImageViewImageCount = 0
    var invokedSetImageViewImageParameters: (url: URL, Void)?
    var invokedSetImageViewImageParametersList = [(url: URL, Void)]()
    
    public func setImageViewImage(with url: URL) {
        invokedSetImageViewImage = true
        invokedSetImageViewImageCount += 1
        invokedSetImageViewImageParameters = (url, ())
        invokedSetImageViewImageParametersList.append((url, ()))
    }
    
    var invokedSetChooseButtonVisibility = false
    var invokedSetChooseButtonVisibilityCount = 0
    var invokedSetChooseButtonVisibilityParameters: (isHidden: Bool, Void)?
    var invokedSetChooseButtonVisibilityParametersList = [(isHidden: Bool, Void)]()
    
    public func setChooseButtonVisibility(isHidden: Bool) {
        invokedSetChooseButtonVisibility = true
        invokedSetChooseButtonVisibilityCount += 1
        invokedSetChooseButtonVisibilityParameters = (isHidden, ())
        invokedSetChooseButtonVisibilityParametersList.append((isHidden, ()))
    }
}
