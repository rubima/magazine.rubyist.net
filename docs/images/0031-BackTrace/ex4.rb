class AssertionError < StandardError
end

def _assert expr
  return if expr
  ex = AssertionError.new("assertion failed")
  ex.set_backtrace(caller())
  raise ex  # –{“–‚Í‚±‚±‚Å—áŠO‚ª”­¶‚µ‚Ä‚é‚¯‚Ç
end

def main
  _assert 1+1 == 3   # ‚ ‚½‚©‚à‚±‚±‚Å”­¶‚µ‚½‚©‚Ì
end                  # ‚æ‚¤‚É‹U‘•‚µ‚Ä‚¢‚é

main()