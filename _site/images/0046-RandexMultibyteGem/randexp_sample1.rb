require "randexp"
 
/\w{10}/.gen               #=> "breastwood" 英数字 10 文字から生成された文字列を返す
/[:email:]/.gen            #=> "chint@phasma.example.org" ランダムな文字列から生成されたメールアドレスを返す
/[:phone_number:]{10}/.gen #=> "862-229-5689" ランダムな数字から生成された電話番号を返す

