//
//  CreatePlaylistViewController.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import UIKit
import SnapKit
import Combine

protocol CreatePlaylistViewDegate: AnyObject {
  func onPlaylistDidCreate(playlist: PlaylistModel)
}

final class CreatePlaylistViewController: ViewController {
  
  // MARK: - UI Properties
  
  let scrollView = UIScrollView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  private let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 45
    $0.alignment = .center
    $0.distribution = .fill
  }
  private let titleLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .avenirMedium(24)
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.text = Localized.createPlaylistTitle
  }
  private let textField = UITextField().then {
    $0.textColor = .white
    $0.font = .avenirMedium(24)
    $0.placeholder = Localized.commonMyPlaylist
    $0.text = Localized.commonMyPlaylist
  }
  private let lineView = UIView().then {
    $0.backgroundColor = .white
  }
  private lazy var confirmButton = UIButton().then {
    $0.setTitle(Localized.commonConfirm, for: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.titleLabel?.font = .avenirMedium(20)
    $0.backgroundColor = .primaryGreen
    $0.cornerRadius = 26
  }
  
  private let viewModel: CreatePlaylistViewModel
  
  // MARK: - Delegates
  
  weak var delegate: CreatePlaylistViewDegate?
  
  // MARK: - Initializers
  
  init(viewModel: CreatePlaylistViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setupActions()
    bindViewModel()
    addKeyboardObserver()
  }
  
  override func keyboardWillShow(notification: Notification) {
    guard let keyboardRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
      return
    }
    scrollView.snp.updateConstraints {
      $0.bottom.equalToSuperview().inset(keyboardRect.height)
    }
  }
  
  override func keyboardWillHidden(notification: Notification) {
    scrollView.snp.updateConstraints {
      $0.bottom.equalToSuperview().inset(0)
    }
  }
}

// MARK: - Private Methods

private extension CreatePlaylistViewController {
  func configureUI() {
    view.backgroundColor = .darkCharcoal
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    scrollView.addSubview(stackView)
    
    stackView.snp.makeConstraints {
      $0.leading.trailing.centerY.equalToSuperview()
      $0.width.equalTo(view)
    }
    stackView.addArrangedSubviews(
      titleLabel,
      textField,
      confirmButton
    )
    textField.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(24)
    }
    textField.addSubview(lineView)
    lineView.snp.makeConstraints {
      $0.bottom.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
    confirmButton.snp.makeConstraints {
      $0.height.equalTo(52)
    }
    stackView.setCustomSpacing(60, after: titleLabel)
    
    textField.becomeFirstResponder()
  }
  
  func setupActions() {
    confirmButton.addPrimaryAction { [weak self] in
      guard let `self` else { return }
      self.viewModel.createPlaylist(with: self.textField.text.orEmpty)
    }
  }
  
  func bindViewModel() {
    viewModel.$playlist
      .sinkOnMainThread(
        onReceiveValue: { [weak self] playlist in
          guard let playlist else { return }
          self?.dismiss(animated: true, completion: { [weak self] in
            self?.delegate?.onPlaylistDidCreate(playlist: playlist)
          })
        },
        storeIn: &cancellables)
  }
}
