//
//  ColorSetVC.swift
//  MakeYourColorApp
//
//  Created by Alexander Lobonenok on 5.09.22.
//

import UIKit

struct ColorSettings {
    let r: Float
    let g: Float
    let b: Float
    let a: Float
}

final class ColorSetVC: UIViewController {
       
    // Lifecycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainView()
        setColors()
        setPreview()
        self.hideKeyboardWhenTappedAround()
    }
    
    // Delegates
    weak var delegate: ColorTransferDelegate?
    
    // Varibales
    var currentColors: ColorSettings?

    // Outlets
    @IBOutlet weak private var mainView: UIView!
    @IBOutlet weak private var redColorField: UITextField!
    @IBOutlet weak private var greenColorField: UITextField!
    @IBOutlet weak private var blueColorField: UITextField!
    @IBOutlet weak private var hexColorField: UITextField!
    @IBOutlet weak private var opacityFiled: UITextField!
    @IBOutlet weak private var previewColor: UIView!
    @IBOutlet weak private var redColorSlider: UISlider!
    @IBOutlet weak private var greenColorSlider: UISlider!
    @IBOutlet weak private var blueColorSlider: UISlider!
    @IBOutlet weak private var opacitySlider: UISlider!
    
    // Actions
    @IBAction private func redColorFieldSet(_ sender: UITextField) {
        redColorSlider.value = Services.rgbConvert(sender.text)
        setPreview()
        setHexField()
    }
    @IBAction private func greenColorFieldSet(_ sender: UITextField) {
        greenColorSlider.value = Services.rgbConvert(sender.text)
        setPreview()
        setHexField()
    }
    @IBAction private func blueColorFieldSet(_ sender: UITextField) {
        blueColorSlider.value = Services.rgbConvert(sender.text)
        setPreview()
        setHexField()
    }
    @IBAction private func hexColorFiledSet(_ sender: UITextField) {
            setAllSlidersForHex()
            setPreview()
    }
    @IBAction private func opacityFiledSet(_ sender: UITextField) {
        opacitySlider.value = Services.rgbConvert(sender.text)
        setPreview()
        setHexField()
    }
    @IBAction private func opacitySliderSet(_ sender: UISlider) {
        opacityFiled.text = String((sender.value * 100).rounded() / 100)
        setPreview()
        setHexField()
    }
    @IBAction private func redSliderChange(_ sender: UISlider) {
        redColorField.text = String((sender.value * 100).rounded() / 100)
        setPreview()
        setHexField()
    }
    @IBAction private func greenSliderChange(_ sender: UISlider) {
        greenColorField.text = String((sender.value * 100).rounded() / 100)
        setPreview()
        setHexField()
    }
    @IBAction private func blueSliderChange(_ sender: UISlider) {
        blueColorField.text = String((sender.value * 100).rounded() / 100)
        setPreview()
        setHexField()
    }
    @IBAction private func selectColorBtn(_ sender: UIButton) {
        let color = ColorSettings(r: redColorSlider.value, g: greenColorSlider.value, b: blueColorSlider.value, a: opacitySlider.value)
        delegate?.changeColor(color)
    }

    // Functions
    private func setMainView() {
        mainView.layer.cornerRadius = 15
    }
    
    private func setColors(){
        if let red = currentColors?.r,
            let green = currentColors?.g,
            let blue = currentColors?.b,
            let alpha = currentColors?.a {
            redColorSlider.value = red
            greenColorSlider.value = green
            blueColorSlider.value = blue
            opacitySlider.value = alpha
            redColorField.text = String((red * 100).rounded() / 100)
            greenColorField.text = String((green * 100).rounded() / 100)
            blueColorField.text = String((blue * 100).rounded() / 100)
            opacityFiled.text = String((alpha * 100).rounded() / 100)
        }
    }
    
    private func setPreview() {
        let red = redColorSlider.value
        let green = greenColorSlider.value
        let blue = blueColorSlider.value
        let alpha = opacitySlider.value
        previewColor.layer.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha)).cgColor
    }
    
    private func setHexField() {
        let red = redColorSlider.value
        let green = greenColorSlider.value
        let blue = blueColorSlider.value
        let alpha = opacitySlider.value
        let hexColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha)).toHexString()
        hexColorField.text = hexColor
    }
    
    private func setAllSlidersForHex() {
        if let stringColor = hexColorField.text {
            let color = UIColor(hex: stringColor)
            if let color = color {
            let ciColor = CIColor(color: color)
                let red = ciColor.red
                let green = ciColor.green
                let blue = ciColor.blue
                redColorSlider.value = Float(red)
                greenColorSlider.value = Float(green)
                blueColorSlider.value = Float(blue)
                opacitySlider.value = Float(1)
            }
        }
    }
}
