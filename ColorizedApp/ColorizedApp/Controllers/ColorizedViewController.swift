//
//  ColorizedViewController.swift
//  ColorizedApp
//
//  Created by Matvei Khlestov on 28.03.2024.
//

import UIKit

// MARK: -  ColorizedViewController
final class ColorizedViewController: UIViewController {
    
    // MARK: -  UI Elements
    private lazy var colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var redColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Red:"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = false
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var greenColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Green:"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = false
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var blueColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Blue:"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = false
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var redValueLabel: UILabel = {
        let label = UILabel()
        label.text = string(from: redSlider)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = false
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var greenValueLabel: UILabel = {
        let label = UILabel()
        label.text = string(from: greenSlider)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = false
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var blueValueLabel: UILabel = {
        let label = UILabel()
        label.text = string(from: blueSlider)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = false
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var redSlider: UISlider = {
        let slider = UISlider()
        slider.value = 1
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .systemGray
        slider.addTarget(self, action: #selector(redSliderChanged), for: .valueChanged)
        
        return slider
    }()
    
    private lazy var greenSlider: UISlider = {
        let slider = UISlider()
        slider.value = 1
        slider.minimumTrackTintColor = .green
        slider.maximumTrackTintColor = .systemGray
        slider.addTarget(self, action: #selector(greenSliderChanged), for: .valueChanged)
        
        return slider
    }()
    
    private lazy var blueSlider: UISlider = {
        let slider = UISlider()
        slider.value = 1
        slider.minimumTrackTintColor = .blue
        slider.maximumTrackTintColor = .systemGray
        slider.addTarget(self, action: #selector(blueSliderChanged), for: .valueChanged)
        
        return slider
    }()
    
    private lazy var redTextField: UITextField = {
        let textField = UITextField()
        textField.text = string(from: redSlider)
        textField.placeholder = "1.00"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        
        return textField
    }()
    
    private lazy var greenTextField: UITextField = {
        let textField = UITextField()
        textField.text = string(from: greenSlider)
        textField.placeholder = "1.00"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        
        return textField
    }()
    
    private lazy var blueTextField: UITextField = {
        let textField = UITextField()
        textField.text = string(from: blueSlider)
        textField.placeholder = "1.00"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        
        return textField
    }()
    
    private lazy var colorLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            redColorLabel, greenColorLabel, blueColorLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var valueLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            redValueLabel, greenValueLabel, blueValueLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var slidersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            redSlider, greenSlider, blueSlider
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        
        return stackView
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            redTextField, greenTextField, blueTextField
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var colorizedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            colorLabelsStackView,
            valueLabelsStackView,
            slidersStackView,
            textFieldsStackView
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: -  Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: -  Action
private extension ColorizedViewController {
    @objc func redSliderChanged() {
        redValueLabel.text = string(from: redSlider)
        redTextField.text = string(from: redSlider)
        
        setColor()
    }
    
    @objc func greenSliderChanged() {
        greenValueLabel.text = string(from: greenSlider)
        greenTextField.text = string(from: greenSlider)
        
        setColor()
    }
    
    @objc func blueSliderChanged() {
        blueValueLabel.text = string(from: blueSlider)
        blueTextField.text = string(from: blueSlider)
        
        setColor()
    }
}

// MARK: -  Private Methods
private extension ColorizedViewController {
    func setupView() {
        view.backgroundColor = .systemIndigo
        addSubviews()
        setColor()
        setConstraints()
    }
    
    func addSubviews() {
        setupSubviews(
            colorView,
            colorizedStackView,
            doneButton
        )
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

// MARK: -  Set Color
private extension ColorizedViewController {
    func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

// MARK: -  Constraints
private extension ColorizedViewController {
    func setConstraints() {
        setConstraintsForColorView()
        setConstraintsForColorLabelsStackView()
        setConstraintsForValueLabelsStackView()
        setConstraintsForTextFieldsStackView()
        setConstraintsForColorizedStackView()
        setConstraintsForDoneButton()
    }
    
    func setConstraintsForColorView() {
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 34
            ),
            colorView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16
            ),
            colorView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16
            ),
            colorView.heightAnchor.constraint(equalToConstant: 128)
        ])
    }
    
    func setConstraintsForColorLabelsStackView() {
        NSLayoutConstraint.activate([
            colorLabelsStackView.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setConstraintsForValueLabelsStackView() {
        NSLayoutConstraint.activate([
            valueLabelsStackView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setConstraintsForTextFieldsStackView() {
        NSLayoutConstraint.activate([
            textFieldsStackView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setConstraintsForColorizedStackView() {
        NSLayoutConstraint.activate([
            colorizedStackView.topAnchor.constraint(
                equalTo: colorView.bottomAnchor, constant: 53
            ),
            colorizedStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16
            ),
            colorizedStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16
            )
        ])
    }
    
    func setConstraintsForDoneButton() {
        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            doneButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -53
            )
        ])
    }
}


