import Wording

open class WordingView<Wording>:
    View
    where
    Wording: Wordingable
{

    open func receive(_ wording: Wording) { }
}
