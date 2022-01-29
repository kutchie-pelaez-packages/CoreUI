import Wording

open class WordingViewController<Wording>:
    ViewController
    where
    Wording: Wordingable
{

    open func receive(_ wording: Wording) { }
}
