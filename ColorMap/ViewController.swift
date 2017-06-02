import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = #imageLiteral(resourceName: "colors.png")
        let countOfColors = 60
        let widthOfImage = Int(floorf(Float(img.size.width)))
        let module = Int(widthOfImage/countOfColors)
        let values = Array(0..<widthOfImage).filter{ $0 % module == 0 }
        
        var colors = "{"
        var index = 20
        values.forEach { i in
            let point = CGPoint(x: i, y: Int(img.size.height/2))
            let color = img.getPixelColor(pos: point)
            guard let image = UIImage(color: UIColor(hexString: color), size: CGSize(width: UIScreen.main.bounds.width, height: 1)) else { return }
            stackView.addArrangedSubview(UIImageView(image: image))
            colors += "\"\(index)\":\"\(color)\","
            index += 1
        }
        
        colors += "}"
        print(colors)
    }
}

