//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Matvei Khlestov on 10.04.2024.
//

import UIKit

// MARK: -  MainViewController
final class MainViewController: UIViewController {
    
    private lazy var settingsButtonTapped = UIAction { [ unowned self ] _ in
        let settingsVC = SettingsViewController()
        settingsVC.viewColor = view.backgroundColor
        settingsVC.delegate = self
        
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .compose,
            primaryAction: settingsButtonTapped
        )
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
