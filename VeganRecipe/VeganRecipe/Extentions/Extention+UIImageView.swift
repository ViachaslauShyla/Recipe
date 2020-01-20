import Foundation

extension UIImageView {

    func showImageBy(_ urlImage: URL) {
        let api = OAIDefaultApi()

        let defaultImageView = DefaultImageView(frame: self.frame)
        self.addSubview(defaultImageView)
        
      //  if let url = URL(string: urlImage) {
            api.downloadImageData(by: urlImage, downloadProgress: { progress in
                defaultImageView.update(with: progress)
            }) { [weak self] data, isCache, error in

                if let image = UIImage(data: data) {
                    defaultImageView.removeFromSuperview()
                    self?.image = image
                }
            }
        //}
    }

    

}
