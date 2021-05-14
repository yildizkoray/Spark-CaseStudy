//
//  ImageViewController.swift
//  CaseStudy
//
//  Created by Koray Yıldız on 13.05.2021.
//

import UIKit
import MobileCoreServices

private struct Constants {
    static let descriptionTextViewBorderWidth: CGFloat = 0.5
    static let textViewPlaceholder = "Enter Description"
    static let camera = "Camera"
    static let photoLibrary = "Photo Library"
    static let cancel = "Cancel"
    static let mediaTypeString = "public.image"
    static let warning = "Warning"
    static let cameraNotFound = "Camera Not Found!"
    static let okay = "Okay"
    static let save = "Save"
    static let update = "Update"
    static let imageViewCornerRadius: CGFloat = 3.0
}

public protocol ImageViewProtocol: AnyObject {
    func prepareUI()
    func prepareUpdateBarButton()
    func prepareSaveBarButton()
    func prepareImagePicker()
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
    
    var imagePicker = UIImagePickerController()
    
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
        let imageBase64Data = imageView.image?.jpegData(compressionQuality: 0.5)?.base64EncodedString(options: .lineLength64Characters)
        presenter.save(title: titleTextField.text, description: descriptionTextView.text, imageBase64Data: imageBase64Data)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            UIAlertController
                .alert(title: Constants.warning, message: Constants.cameraNotFound)
                .addActions(
                    UIAlertAction(title: Constants.okay, style: .cancel)
                )
                .show(onto: self, animated: true)
        }
    }
    
    private func photoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        }
    }
    
    @IBAction private func chooseButtonDidTap() {
        UIAlertController
            .actionSheet()
            .addActions(
                UIAlertAction(title: Constants.camera, style: .default, handler: { [weak self] action in
                    self?.openCamera()
                }),
                UIAlertAction(title: Constants.photoLibrary, style: .default, handler: { [weak self] action in
                    self?.photoLibrary()
                }),
                UIAlertAction(title: Constants.cancel, style: .cancel)
            )
            .show(onto: self, animated: true)
    }
    
    @IBAction func rotateToRightButtonDidTap() {
        DispatchQueue.main.async {
            self.imageView.image = self.imageView.image?.rotate(radians: .pi / 2)
        }
    }
    
    @IBAction func rotateToLeftButtonDidTap() {
        DispatchQueue.main.async {
            self.imageView.image = self.imageView.image?.rotate(radians: -.pi / 2)
        }
    }
}

// MARK: - ImageViewProtocol
extension ImageViewController: ImageViewProtocol {
    
    public func prepareImagePicker() {
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.mediaTypes = [String(kUTTypeImage)]
    }
    
    public func prepareUpdateBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.update,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(updateBarButtonDidTap))
    }
    
    public func prepareSaveBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.save,
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
        descriptionTextView.text = Constants.textViewPlaceholder
        descriptionTextView.textColor = .lightGray
        descriptionTextView.delegate = self
        
        imageView.layer.borderWidth = Constants.descriptionTextViewBorderWidth
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = Constants.imageViewCornerRadius
        imageView.layer.masksToBounds = true
    }
}

// MARK: - UITextViewDelegate
extension ImageViewController: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        guard let description = textView.text else { return }
        if description == Constants.textViewPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        guard let description = textView.text else { return }
        if description.isEmpty {
            textView.text = Constants.textViewPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let mediaType = info[.mediaType] {
            if mediaType as? String  == Constants.mediaTypeString {
                let image = info[.editedImage] as! UIImage
                imageView.image = image
            }
        }
    }
}
