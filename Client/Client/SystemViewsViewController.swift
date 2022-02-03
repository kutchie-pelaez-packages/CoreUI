import CoreUI
import UIKit

final class SystemViewsViewController: ViewController {
    private var tableView: System.TableView!

    override func configureViews() {
        view.backgroundColor = System.Colors.Background.secondary
    }

    override func configureNavigationBar() {
        navigationItem.title = "System views"

        tableView = System.TableView()
        tableView.state = System.TableView.State(
            sections: [
                checkmarkedViewsSection,
            ]
        )
        view.addSubviews(tableView)
    }

    override func constraintViews() {
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }

    // MARK: - Sections

    private var checkmarkedViewsSection: System.TableView.Section {
        System.TableView.Section(
            rows: [
                System.TableView.Row(
                    constructor: { CheckmarkedView(Square()) },
                    constraining: .center
                )
            ],
            header: System.TableView.SystemHeader(
                text: "CheckmarkedView"
            )
        )
    }

    // MARK: - Rows
}
