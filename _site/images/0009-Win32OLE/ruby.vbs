Dim sc

Set sc = CreateObject("ScriptControl")
sc.Language = "GlobalRubyScript"

sc.AddCode("def add x,y;x + y;end")

WScript.Echo(sc.Run("add",2,3))