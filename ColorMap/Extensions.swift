import UIKit

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func getPixelColor(pos: CGPoint) -> String {
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = data[pixelInfo]
        let g = data[pixelInfo+1]
        let b = data[pixelInfo+2]
        let a = data[pixelInfo+3]
        
        return "#" + r.base16string + g.base16string + b.base16string
    }
}

extension UIColor {
    convenience init(hexString:String) {
        let hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner   = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
public extension UInt8 {
    var base16string: String {
        let string = String(self, radix: 16)
        return string.characters.count == 1 ? "0" + string : string
    }
}
