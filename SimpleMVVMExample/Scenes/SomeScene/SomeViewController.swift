//
//  SomeViewController.swift
//  SimpleMVVMExample
//
//  Created by Yuriy Kudrovsky on 30.08.2022.
//

import UIKit

// MARK: - Constants

private enum Constans {
    static let titleLabelWidth = 200.0
    static let titleLabelHeight = 100.0
    static let titleLabelTopInsetFactor = 12.0
    
    static let valueLabelWidth = 200.0
    static let valueLabelHeight = 180.0
    static let valueLabelTopInsetFactor = 3.7
    static let valueLabelFontSize = 120.0
    
    static let buttonWidth = 200.0
    static let buttonHeight = 44.0
    static let buttonTopInsetFactor = 1.5
    static let buttonRadiusFactor = 2.0
    static let buttonBorderWidthFactor = 2.0
    
    static let centerationFactor = 2.0
    
    static let viewTitleValue = "Simple MVVM Example"
    static let buttonTitleValue = "Update Model"
}

// MARK: - Implementation

final class SomeViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let viewModel: SomeViewModel
    
    // MARK: - UI properties
    
    lazy var titleView: UILabel = {
        let view = UILabel(frame: CGRect(x: view.frame.width / Constans.centerationFactor - Constans.titleLabelWidth / Constans.centerationFactor,
                                         y: view.frame.height / Constans.titleLabelTopInsetFactor,
                                         width: Constans.titleLabelWidth,
                                         height: Constans.titleLabelHeight))
        view.textColor = .white
        view.textAlignment = .center
        view.text = Constans.viewTitleValue
        return view
    }()
    
    lazy var valueView: UILabel = {
        let view = UILabel(frame: CGRect(x: view.frame.width / Constans.centerationFactor - Constans.valueLabelWidth / Constans.centerationFactor,
                                         y: view.frame.height / Constans.valueLabelTopInsetFactor,
                                         width: Constans.valueLabelWidth,
                                         height: Constans.valueLabelHeight))
        view.font = UIFont.systemFont(ofSize: Constans.valueLabelFontSize)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    lazy var buttonView: UIButton = {
        let view = UIButton(frame: CGRect(x: view.frame.width / Constans.centerationFactor - Constans.buttonWidth / Constans.centerationFactor,
                                          y: view.frame.height / Constans.buttonTopInsetFactor,
                                          width: Constans.buttonWidth,
                                          height: Constans.buttonHeight))
        view.backgroundColor = .clear
        view.layer.cornerRadius = Constans.buttonHeight / Constans.buttonRadiusFactor
        view.layer.borderWidth = Constans.buttonBorderWidthFactor
        view.layer.borderColor = UIColor.blue.cgColor
        view.addTarget(self, action: #selector(didSelectButton), for: .touchUpInside)
        view.setTitle(Constans.buttonTitleValue, for: .normal)
        return view
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: SomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }

}

private extension SomeViewController {
    
    func setupViewModel() {
        viewModel.onModelUpdate = { [weak self] value in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.valueView.text = value
            }
        }
    }
    
}

// MARK: - UI managment

private extension SomeViewController {
    
    func setupView() {
        view.addSubview(titleView)
        view.addSubview(valueView)
        view.addSubview(buttonView)
    }
    
}

// MARK: - Actions

private extension SomeViewController {
    
    @objc func didSelectButton() {
        viewModel.didTapButton()
    }
    
}

