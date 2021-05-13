//
//  ImageViewController.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import UIKit

private struct Constants {
    static let descriptionTextViewBorderWidth: CGFloat = 0.5
}

public protocol ImageViewProtocol: AnyObject {
    func prepareUI()
    func prepareUpdateBarButton()
    func prepareSaveBarButton()
    func setTitle(with title: String)
    func setTitleTextFieldText(text: String)
    func setDescriptionTextViewText(text: String)
    func setImageViewImage(with url: URL)
    func setChooseButtonVisibility(isHidden: Bool)
}

public final class ImageViewController: UIViewController, ViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var chooseButton: UIButton!
    
    public static var storyboardName: UIStoryboard.Name = .main
    
    public var presenter: ImagePresenterProtocol!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @objc private func updateBarButtonDidTap() {
        descriptionTextView.resignFirstResponder()
        presenter.update(title: titleTextField.text, description: descriptionTextView.text)
    }
    
    @objc private func saveBarButtonDidTap() {
        titleTextField.resignFirstResponder()
        let imageBase64Data = imageView.image?.jpegData(compressionQuality: 0.8)?.base64EncodedString(options: .lineLength64Characters)
        presenter.save(title: titleTextField.text, description: descriptionTextView.text, imageBase64Data: imageBase64Data)
    }
    @IBAction func chooseButtonDidTap() {
        
    }
}

// MARK: - ImageViewProtocol
extension ImageViewController: ImageViewProtocol {
    
    public func prepareUpdateBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(updateBarButtonDidTap))
    }
    
    public func prepareSaveBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveBarButtonDidTap))
    }
    
    public func setChooseButtonVisibility(isHidden: Bool) {
        chooseButton.isHidden = isHidden
    }
    
    public func setTitle(with title: String) {
        self.title = title
    }
    
    public func setTitleTextFieldText(text: String) {
        titleTextField.text = text
    }
    
    public func setDescriptionTextViewText(text: String) {
        descriptionTextView.text = text
    }
    
    public func setImageViewImage(with url: URL) {
        imageView.af.setImage(withURL: url)
    }
    
    public func prepareUI() {
        descriptionTextView.layer.borderWidth = Constants.descriptionTextViewBorderWidth
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.text = "Enter Description"
        descriptionTextView.delegate = self
        
        imageView.layer.borderWidth = Constants.descriptionTextViewBorderWidth
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 3.0
        imageView.layer.masksToBounds = true
        
        titleTextField.delegate = self
    }
}

// MARK: - UITextViewDelegate
extension ImageViewController: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        guard let description = textView.text else { return }
        if description == "Enter Description" {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        guard let description = textView.text else { return }
        if description.isEmpty {
            textView.text = "Enter Description"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension ImageViewController: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let description = textField.text else { return }
    }
}
