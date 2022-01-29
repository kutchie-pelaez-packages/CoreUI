import Wording

open class WordingButton<Wording>:
    Button
    where
    Wording: Wordingable
{

    open func receive(_ wording: Wording) { }
}
