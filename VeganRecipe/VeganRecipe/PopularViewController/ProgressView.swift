
import UIKit

class ProgressView: UIView {

    private var radius: CGFloat {
        return min(self.frame.width / 2, self.frame.height / 2)
    }

    private var startAngle: CGFloat {
        return CGFloat.pi / 2
    }

    var progress: Progress? {
        didSet {
            self.setNeedsDisplay()
        }
    }

    private var endAngle: CGFloat {
        if let progress = progress {
            return CGFloat.pi * 2 * CGFloat(progress.completedUnitCount) / CGFloat(progress.totalUnitCount)
        } else {
            return startAngle
        }
    }

    override func draw(_ rect: CGRect) {

        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: CGFloat.pi * 2, clockwise: true)
        UIColor.lightGray.setStroke()
        path.stroke()

        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        UIColor.gray.setStroke()
        progressPath.stroke()
    }
}
