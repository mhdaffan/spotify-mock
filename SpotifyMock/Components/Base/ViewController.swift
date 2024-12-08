//
//  ViewController.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 06/12/24.
//

import UIKit
import SnapKit
import Combine

class ViewController: UIViewController {
  
  var cancellables: Set<AnyCancellable> = []
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    tabBarController?.tabBar.isHidden = true
  }
  
  deinit {
    cancellables.removeAll()
    removeKeyboardObserver()
  }
  
  @objc func onTapScreen(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  @objc func keyboardWillShow(notification: Notification) {}
  
  @objc func keyboardShow(notification: Notification) {}
  
  @objc func keyboardWillHidden(notification: Notification) {}
}

// MARK: - Internal Methods

extension ViewController {
  
  func applyStandardAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithTransparentBackground()
    appearance.backgroundColor = .black
    appearance.setBackIndicatorImage(.icBack.withColor(.white), transitionMaskImage: .icBack.withColor(.white))
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
  }
  
  func addLeftBarTitle(title: String) {
    let titleLabel = UILabel().then {
      $0.text = title
      $0.textColor = .white
      $0.font = UIFont.avenirDemiBold(24)
    }
    addLeftBarItem(view: titleLabel)
  }
  
  func addRightBarButtonItem(image: UIImage?, size: CGSize = CGSize(width: 24, height: 24), action: Selector? = nil) {
    let button = UIButton(type: .system).then {
      $0.frame.size = size
      $0.setImage(image, for: .normal)
      $0.isUserInteractionEnabled = action != nil
    }
    if let action {
      button.addTarget(self, action: action, for: .touchUpInside)
    }
    addRightBarItem(view: button)
  }
  
  func addLeftBarButtonItem(image: UIImage?, size: CGSize = CGSize(width: 24, height: 24), action: Selector? = nil) {
    let button = UIButton(type: .system).then {
      $0.frame.size = size
      $0.setImage(image, for: .normal)
      $0.isUserInteractionEnabled = action != nil
    }
    if let action {
      button.addTarget(self, action: action, for: .touchUpInside)
    }
    addLeftBarItem(view: button)
  }
  
  func addRightBarItem(view: UIView) {
    var items: [UIBarButtonItem] = navigationItem.rightBarButtonItems ?? []
    items.append(UIBarButtonItem(customView: view))
    navigationItem.setRightBarButtonItems(items, animated: true)
  }
  
  func addLeftBarItem(view: UIView) {
    var items: [UIBarButtonItem] = navigationItem.leftBarButtonItems ?? []
    items.append(UIBarButtonItem(customView: view))
    navigationItem.setLeftBarButtonItems(items, animated: true)
  }
  
  func setLoadingIndicator(on view: UIView? = nil, isLoading: Bool) {
    let view: UIView = UIApplication.shared.keyWindow ?? self.view
    isLoading ? showLoadingIndicator(on: view) : hideLoadingIndicator(on: view)
  }
  
  func enableTapGestureOnView(cancelsTouchesInView: Bool = false) {
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.onTapScreen))
    view.isUserInteractionEnabled = true
    tapGesture.cancelsTouchesInView = cancelsTouchesInView
    view.addGestureRecognizer(tapGesture)
  }
  
  func addKeyboardObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func removeKeyboardObserver() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
}

// MARK: - Private Methods

private extension ViewController {
  func configureUI() {
    view?.backgroundColor = .black
    configureNavBarBackButton()
  }
  
  func configureNavBarBackButton() {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    navigationController?.navigationBar.backIndicatorImage = .icBack.withColor(.white)
    navigationController?.navigationBar.backIndicatorTransitionMaskImage = .icBack.withColor(.white)
  }
  
  func showLoadingIndicator(on view: UIView) {
    guard view.viewWithTag(100001) == nil else {
      return
    }
    
    let indicator = UIActivityIndicatorView(style: .large).then {
      $0.color = .primaryGreen
      $0.tag = 100001
    }
    
    view.addSubview(indicator)
    indicator.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.height.equalTo(200)
    }
    
    indicator.startAnimating()
  }
  
  func hideLoadingIndicator(on view: UIView) {
    view.viewWithTag(100001)?.removeFromSuperview()
  }
}
