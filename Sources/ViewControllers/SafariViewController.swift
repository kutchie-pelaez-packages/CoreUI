import SafariServices
import SnapKit
import UIKit

public final class SafariViewController: ViewController {
    public init(
        url: URL,
        barCollapsingEnabled: Bool = false
    ) {
        self.url = url
        self.barCollapsingEnabled = barCollapsingEnabled
        super.init()
    }

    private let url: URL
    private let barCollapsingEnabled: Bool

    // MARK: - UI

    private weak var safariView: UIView?

    public override func configureViews() {
        let configuration = SFSafariViewController.Configuration()
        configuration.barCollapsingEnabled = barCollapsingEnabled

        let safariViewController = SFSafariViewController(
            url: url,
            configuration: configuration
        )
        addChildViewController(safariViewController)
        safariView = safariViewController.view
    }

    public override func constraintViews() {
        safariView?.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
}
