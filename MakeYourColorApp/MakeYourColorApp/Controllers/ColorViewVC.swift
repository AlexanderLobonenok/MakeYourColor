//
//  ColorViewVC.swift
//  MakeYourColorApp
//
//  Created by Alexander Lobonenok on 5.09.22.
//

import UIKit

protocol ColorTransferDelegate: AnyObject {
    func changeColor(_ color: ColorSettings)
}

final class ColorViewVC: UIViewController {
    
    // MARK: - Life circle

    override func viewDidLoad() {
        super.viewDidLoad()
        noColorSet()
    }
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak private var selectColorLabel: UILabel!
    @IBOutlet weak private var colorView: UIView!
    
    // MARK: - Properties
    
    private var currentColor: ColorSettings?
    
    // MARK: - Navigations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segue = segue.destination as? ColorSetVC else { return }
        segue.delegate = self
        segue.currentColors = currentColor
    }
    
    // MARK: - @IBActions
    
    @IBAction private func selectColorBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToColorSet", sender: nil)
    }
    
    // MARK: - Private funcs
    
    private func noColorSet() {
        colorView.layer.borderColor = UIColor.red.cgColor
        colorView.layer.borderWidth = 1
    }
}

extension ColorViewVC: ColorTransferDelegate {
    func changeColor(_ color: ColorSettings) {
        selectColorLabel.text = "You've make this color"
        colorView.layer.backgroundColor = UIColor(red: CGFloat(color.r), green: CGFloat(color.g), blue: CGFloat(color.b), alpha: CGFloat(color.a)).cgColor
        colorView.layer.borderWidth = 0
        currentColor = ColorSettings(r: color.r, g: color.g, b: color.b, a: color.a)
    }
}
