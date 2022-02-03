import UIKit

extension System.TableView {
    final class ViewCell: TableViewCell {
        func embed(_ view: UIView, using constraining: ViewRow.Constraining) {
            self.embeddedView?.removeFromSuperview()
            contentView.addSubviews(view)

            self.embeddedView = view
            self.constraining = constraining

            setNeedsUpdateConstraints()
        }

        private var embeddedView: UIView?
        private var constraining: ViewRow.Constraining?

        override func updateConstraints() {
            defer { super.updateConstraints() }

            guard
                let embeddedView = embeddedView,
                let constraining = constraining
            else {
                return
            }

            switch constraining {
            case let .fill(insets):
                embeddedView.snp.makeConstraints { make in
                    make.directionalEdges.equalToSuperview().inset(insets)
                }

            case let .center(topInset, bottomInset, centerInset):
                embeddedView.snp.makeConstraints { make in
                    make.centerX.equalToSuperview().inset(centerInset)
                    make.top.equalToSuperview().inset(topInset)
                    make.bottom.equalToSuperview().inset(bottomInset)
                }

            case let .leading(topInset, bottomInset, leadingInset):
                embeddedView.snp.makeConstraints { make in
                    make.leading.equalToSuperview().inset(leadingInset)
                    make.top.equalToSuperview().inset(topInset)
                    make.bottom.equalToSuperview().inset(bottomInset)
                }

            case let .trailing(topInset, bottomInset, trailingInset):
                embeddedView.snp.makeConstraints { make in
                    make.trailing.equalToSuperview().inset(trailingInset)
                    make.top.equalToSuperview().inset(topInset)
                    make.bottom.equalToSuperview().inset(bottomInset)
                }
            }
        }
    }
}
