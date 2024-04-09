//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Matvei Khlestov on 28.03.2024.
//

import UIKit

// MARK: -  SettingsViewControllerDelegate
protocol SettingsViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}

// MARK: -  SettingsViewController
final class SettingsViewController: UIViewController {
    
    // MARK: -  Public Properties
    unowned var delegate: SettingsViewControllerDelegate!
    var viewColor: UIColor!
    
    // MARK: -  UI Elements
    private lazy var colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var redColorLabel: UILabel = {
        createLabel(text: "Red:")
    }()
    
    private lazy var greenColorLabel: UILabel = {
        createLabel(text: "Green:")
    }()
    
    private lazy var blueColorLabel: UILabel = {
        createLabel(text: "Blue:")
    }()
    
    private lazy var redValueLabel: UILabel = {
        createLabel()
    }()
    
    private lazy var greenValueLabel: UILabel = {
        createLabel()
    }()
    
    private lazy var blueValueLabel: UILabel = {
        createLabel()
    }()
    
    private lazy var redSlider: UISlider = {
        createSlider(trackTintColor: .red, action: sliderChanged, tag: 0)
    }()
    
    private lazy var greenSlider: UISlider = {
        createSlider(trackTintColor: .green, action: sliderChanged, tag: 1)
    }()
    
    private lazy var blueSlider: UISlider = {
        createSlider(trackTintColor: .blue, action: sliderChanged, tag: 2)
    }()
    
    private lazy var redTextField: UITextField = {
        createTextField()
    }()
    
    private lazy var greenTextField: UITextField = {
        createTextField()
    }()
    
    private lazy var blueTextField: UITextField = {
        createTextField()
    }()
    
    private lazy var colorLabelsStackView: UIStackView = {
        createChildStackView(
            subviews: [redColorLabel, greenColorLabel, blueColorLabel],
            spacing: 25
        )
    }()
    
    private lazy var valueLabelsStackView: UIStackView = {
        createChildStackView(
            subviews: [redValueLabel, greenValueLabel, blueValueLabel],
            spacing: 25
        )
    }()
    
    private lazy var slidersStackView: UIStackView = {
        createChildStackView(
            subviews: [redSlider, greenSlider, blueSlider],
            spacing: 12
        )
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        createChildStackView(
            subviews: [redTextField, greenTextField, blueTextField],
            spacing: 10
        )
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
        let button = UIButton(type: .system, primaryAction: doneButtonTapped)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: -  Action
    private lazy var sliderChanged = UIAction { [ unowned self ] action in
        guard let sender = action.sender as? UISlider else { return }
        
        switch sender.tag {
        case 0:
            setValue(for: redValueLabel)
            setValue(for: redTextField)
        case 1:
            setValue(for: greenValueLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueValueLabel)
            setValue(for: blueTextField)
        }
        
        setColor()
        
    }
    
    private lazy var doneButtonTapped = UIAction { [ unowned self ] _ in
        delegate.setColor(colorView.backgroundColor ?? .white)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: -  Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: -  Private Methods
private extension SettingsViewController {
    func setupView() {
        view.backgroundColor = .systemIndigo
        
        addSubviews()
        
        setColor()
        
        colorView.backgroundColor = viewColor
        
        setValue()
        
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        
        setValue(for: redTextField, greenTextField, blueTextField)
        
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
    
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    func createLabel(text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        
        return label
    }
    
    func createTextField() -> UITextField {
        let textField = UITextField()
        textField.placeholder = "0.00"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.delegate = self
        
        return textField
    }
    
    func createSlider(trackTintColor: UIColor, action: UIAction, tag: Int) -> UISlider {
        let slider = UISlider(frame: .zero, primaryAction: action)
        slider.value = 1
        slider.minimumTrackTintColor = trackTintColor
        slider.maximumTrackTintColor = .systemGray
        slider.tag = tag
        
        return slider
    }
    
    func createChildStackView(subviews: [UIView], spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
}

// MARK: -  Set Color
private extension SettingsViewController {
    func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

// MARK: -  Set Value
private extension SettingsViewController {
    func setValue() {
        let ciColor = CIColor(color: viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                label.text = string(from: redSlider)
            case greenValueLabel:
                label.text = string(from: greenSlider)
            default: 
                label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = string(from: redSlider)
            case greenTextField:
                textField.text = string(from: greenSlider)
            default: 
                textField.text = string(from: blueSlider)
            }
        }
    }
}

// MARK: -  Constraints
private extension SettingsViewController {
    func setConstraints() {
        setConstraintsForColorView()
        setConstraintsForChildStackViews(colorLabelsStackView, constant: 44)
        setConstraintsForChildStackViews(valueLabelsStackView, constant: 30)
        setConstraintsForChildStackViews(textFieldsStackView, constant: 50)
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
    
    func setConstraintsForChildStackViews(_ stackView: UIStackView, constant: CGFloat) {
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: constant)
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

// MARK: -  Alert Controller
private extension SettingsViewController {
    private func showAlert(withTitle title: String, andMessage message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "0.50"
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(withTitle: "Wrong format!", andMessage: "Please enter correct value")
            return
        }
        
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(
                withTitle: "Wrong format!",
                andMessage: "Please enter correct value",
                textField: textField
            )
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(currentValue, animated: true)
            setValue(for: redValueLabel)
        case greenTextField:
            greenSlider.setValue(currentValue, animated: true)
            setValue(for: greenValueLabel)
        default:
            blueSlider.setValue(currentValue, animated: true)
            setValue(for: blueValueLabel)
        }
        
        setColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard textField != redTextField else { return }
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}

