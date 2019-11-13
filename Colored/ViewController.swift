


import Cocoa


class ViewController: NSViewController {

    
    @IBOutlet weak var primaryColorView: NSView!
    @IBOutlet weak var secondaryColorView: NSView!
    @IBOutlet weak var tertiaryColorView: NSView!
    
    @IBOutlet weak var primaryHueWheel: NSSlider!
    
    @IBOutlet weak var hueSlider: NSSlider!
    @IBAction func hueSliderAction(_ sender: Any) {
        updateColorView()
    }
    
    
    @IBOutlet weak var saturationSlider: NSSlider!
    @IBAction func saturationSliderAction(_ sender: Any) {
        updateColorView()
    }
    
    
    @IBOutlet weak var brightnessSlider: NSSlider!
    @IBAction func brightnessSliderAction(_ sender: Any) {
        updateColorView()
    }
    
    
    
    @IBAction func randomButtonAction(_ sender: Any) {
        hueSlider.floatValue = Float.random(in: 0...1.0)
        saturationSlider.floatValue = Float.random(in: 0.5...1.0)
        brightnessSlider.floatValue = Float.random(in: 0.75...1.0)
        updateColorView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    
    override func viewDidAppear() {
        configureView()
    }
    

    func configureView() {
        
        print("configureView")
        
        primaryColorView.wantsLayer = true
        secondaryColorView.wantsLayer = true
        tertiaryColorView.wantsLayer = true
        
        primaryColorView.layer?.cornerRadius = 3.0
        secondaryColorView.layer?.cornerRadius = 3.0
        tertiaryColorView.layer?.cornerRadius = 3.0
        
        
        // DRY Code (don’t repeat yourself)
        let sliderMinValue  = 0.0
        let sliderMaxValue = 1.0
        
        hueSlider.minValue = sliderMinValue
        hueSlider.maxValue = sliderMaxValue
        hueSlider.floatValue = Float(sliderMaxValue * 0.1)
        hueSlider.sendAction(on: .leftMouseDragged)
        
        saturationSlider.minValue = sliderMinValue
        saturationSlider.maxValue = sliderMaxValue
        saturationSlider.floatValue = Float(sliderMaxValue * 0.8)
        saturationSlider.sendAction(on: .leftMouseDragged)
        
        brightnessSlider.minValue = sliderMinValue
        brightnessSlider.maxValue = sliderMaxValue
        brightnessSlider.floatValue = Float(sliderMaxValue * 0.9)
        brightnessSlider.sendAction(on: .leftMouseDragged)
        
        
        primaryHueWheel.minValue = sliderMinValue
        primaryHueWheel.maxValue = sliderMaxValue
        
        
        updateColorView()
        
    }
    
    
    func updateColorView() {
        
        print("updateColorView")
        
        let h = CGFloat(hueSlider.floatValue)
        let s = CGFloat(saturationSlider.floatValue)
        let b = CGFloat(brightnessSlider.floatValue)

        
        // Primary
        let primaryColor = NSColor(hue: h,
                                   saturation: s,
                                   brightness: b,
                                   alpha: 1.0)
        
        primaryColorView.layer?.backgroundColor = primaryColor.cgColor
        
        
        // Secondary
        var secondaryHue = h - 0.333
        if secondaryHue < 0.0 {
            secondaryHue = 1.0 + secondaryHue
        }
        let secondaryColor = NSColor(hue: secondaryHue,
                                     saturation: s,
                                     brightness: b,
                                     alpha: 1.0)
        
        secondaryColorView.layer?.backgroundColor = secondaryColor.cgColor
        
        
        // Tertiary
        var tertiaryHue = h + 0.333
        if tertiaryHue > 1.0 {
            tertiaryHue = tertiaryHue - 1.0
        }
        let tertiaryColor = NSColor(hue: tertiaryHue,
                                    saturation: s,
                                    brightness: b,
                                    alpha: 1.0)
        
        tertiaryColorView.layer?.backgroundColor = tertiaryColor.cgColor
        
        
        // Window
        self.view.window?.title = "sat \(Int(s * 100))%"
        
        
        // Wheel
        primaryHueWheel.floatValue = Float(h)
        
    }


    
}

