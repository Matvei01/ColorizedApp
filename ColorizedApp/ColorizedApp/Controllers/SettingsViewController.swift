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
        let slider = UISlider(frame: .zero, primaryAction: sliderChanged)
        slider.value = 1
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .systemGray
        slider.tag = 0
        
        return slider
    }()
    
    private lazy var greenSlider: UISlider = {
        let slider = UISlider(frame: .zero, primaryAction: sliderChanged)
        slider.value = 1
        slider.minimumTrackTintColor = .green
        slider.maximumTrackTintColor = .systemGray
        slider.tag = 1
        
        return slider
    }()
    
    private lazy var blueSlider: UISlider = {
        let slider = UISlider(frame: .zero, primaryAction: sliderChanged)
        slider.value = 1
        slider.minimumTrackTintColor = .blue
        slider.maximumTrackTintColor = .systemGray
        slider.tag = 2
        
        return slider
    }()
    
    private lazy var redTextField: UITextField = {
        let textField = UITextField()
        textField.text = string(from: redSlider)
        textField.placeholder = "0.00"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var greenTextField: UITextField = {
        let textField = UITextField()
        textField.text = string(from: greenSlider)
        textField.placeholder = "0.00"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var blueTextField: UITextField = {
        let textField = UITextField()
        textField.text = string(from: blueSlider)
        textField.placeholder = "0.00"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.delegate = self
        
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
            redValueLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case 1:
            greenValueLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueValueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
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
}



// MARK: -  Constraints
private extension SettingsViewController {
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

// MARK: -  Alert Controller
private extension SettingsViewController {
    private func showAlert(withTitle title: String, andMessage message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
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
            redValueLabel.text = string(from: redSlider)
        case greenTextField:
            greenSlider.setValue(currentValue, animated: true)
            greenValueLabel.text = string(from: greenSlider)
        default:
            blueSlider.setValue(currentValue, animated: true)
            blueValueLabel.text = string(from: blueSlider)
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

