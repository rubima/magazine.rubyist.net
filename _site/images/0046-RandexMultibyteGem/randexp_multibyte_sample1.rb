require "randexp-multibyte"

/[:hiragana:]{3}/.gen #=> "けさぎ"    ひらがな 3 文字から生成された文字列を返す
/[:katakana:]{2}/.gen #=> "ドヘ"      カタカナ 2 文字から生成された文字列を返す
/[:kanji:]{5}/.gen    #=> "脈菌握亭村" (常用) 漢字 5 文字から生成された文字列を返す
/[:japanese:]{5}/.gen #=> "シど敷キ飾" 漢字+ひらがな+カタカナ 5 文字から生成された文字列を返す
/\w{7}/.gen           #=> "lapwork"  randexp の機能は継承

