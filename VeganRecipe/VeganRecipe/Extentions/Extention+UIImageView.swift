import Foundation

extension UIImageView {
    private static var sessions = [UIImageView : (URLSessionDataTask, DefaultImageView)]()
    
    func showImageBy(_ urlImage: URL?) {
        UIImageView.sessions[self]?.0.cancel()
        UIImageView.sessions[self]?.1.removeFromSuperview()
        UIImageView.sessions.removeValue(forKey: self)

        guard let url = urlImage else { return }

        var tuple: (URLSessionDataTask, DefaultImageView)
        let progressView = DefaultImageView(frame: self.bounds)
        tuple.1 = progressView
        tuple.0 = OAIDefaultApi().downloadImage(from: url, progress: { progressView.update(with: $0) }) { (img, isFromCache, e) in
            self.image = img
            UIImageView.sessions[self]?.1.removeFromSuperview()
            UIImageView.sessions.removeValue(forKey: self)
        }

        UIImageView.sessions[self] = tuple
        self.addSubview(progressView)
    }
}
