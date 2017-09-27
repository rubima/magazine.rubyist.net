=begin
		dbf.rb
		
		05-11-21
=end

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#		DBFheader
#		ヘッダ先導部
#
# インターフェイス
#		version, date1, date2, date3, numrec, headerbytes, recordbytes, reserve
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class DBFheader
	def initialize
		@version = nil			# バージョンなど
		@date1 = nil				# 最終更新日(年）
		@date2 = nil				# 最終更新日(月）
		@date3 = nil				# 最終更新日(日）
		@numrec = nil				# レコード数
		@headerbytes = nil	# ヘッダのバイト数
		@recordbytes = nil	# レコードのバイト数
		@reserve = nil			# 予約領域など
	end
	attr_accessor :version, :date1, :date2, :date3, :numrec, :headerbytes, :recordbytes, :reserve
end

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#		DBFfield
#		フィールド要素
#
# インターフェイス
#		fieldname, fieldtype, fieldsize, decimal, value
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class DBFfield
	def initialize
		@fieldname = ""			#フィールド名
		@fieldtype = ""			#フィールド型
		@fieldsize = 0			#フィールド長
		@decimal = 0				#フィールド小数部長
		@value = nil				#フィールド値
	end
	attr_accessor :fieldname, :fieldtype, :fieldsize, :decimal, :value
end

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#		DBFfields
#		フィールド記述配列
#
# インターフェイス
#		add, fieldname, item, numfields
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class DBFfields
	def initialize
		@fieldarray = []		#フィールド要素の配列
		@fieldhash = {}			#フィールド名でアクセスするためのハッシュ配列
	end

#-----------------------------------------------------------------------
#		add
#
#		フィールド定義を引数に、フィールド配列にフィールド要素を追加する
#
# 引数
#		fname：フィールド名
#		ftype：型
#		fsize：フィールド長
#		dec：小数部長
# 戻り値
#		なし
#-----------------------------------------------------------------------
	def add(fname, ftype, fsize, dec)
		@field = DBFfield.new
		@field.fieldname = fname
		@field.fieldtype = ftype
		@field.fieldsize = fsize
		@field.decimal = dec

		@fieldarray.push(@field)
		@fieldhash[@field.fieldname] = @fieldarray.size - 1		#フィールド名に対応するフィールド番号を取得する
	end

#-----------------------------------------------------------------------
#		fieldname
#
# 概要
#		フィールド番号を引数に、フィールド名を返す
#
# 引数
#		num：フィールド番号
# 戻り値
#		フィールド名
#-----------------------------------------------------------------------
	def fieldname(num)
		@fieldarray[num].fieldname
	end

#-----------------------------------------------------------------------
#		item
#		フィールドへのアクセス
#
# 概要
#		フィールド名を引数に、フィールド記述配列の要素を返す
#
# 引数
#		フィールド名
# 戻り値
#		フィールド要素
#-----------------------------------------------------------------------
	def item(fname)
		@fieldarray[@fieldhash[fname]]
	end

#-----------------------------------------------------------------------
#		numfields
#
# 概要
#		フィールド記述配列の要素数を返す
#
# 引数
#		なし
# 戻り値
#		フィールド数
#-----------------------------------------------------------------------
	def numfields
		@fieldarray.size
	end
end		# class DBFfields

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#		DBFrecordset
#
# 概要
#		データベースファイルは、以下の３つの部分からなる
#		１　ヘッダ先導部
#		２　フィールド記述部
#		３　データレコード部
#
# インターフェイス
#		addfield, dbfopen, close, eof, movefirst, movenext, addnew, update
#		numfields, fieldname, fieldspec, fields
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class DBFrecordset
	def initialize
		@hdlead = DBFheader.new		#ヘッダ先導部
		@fields = DBFfields.new		#フィールド記述配列

		@dbfeof = FALSE			#EOF
		@dbfbof = FALSE			#BOF
		@headerset = FALSE	# ファイルにヘッダ部が書き込まれているか
		@currentrecno = -1	# 0から始まるレコード番号
		@numrecords = 0			# 1から始まるレコード数
		@headerlen = 0			# ヘッダ長 
		@recordlen = 0			# レコード長
	end

#-----------------------------------------------------------------------
#		addfield
#
# 引数
#		fname：フィールド名
#		ftype：型
#		fsize：フィールド長
#		dec：小数部長
# 戻り値
#		なし
#-----------------------------------------------------------------------
	def addfield(fname, ftype, fsize, dec)
		@fields.add(fname, ftype, fsize, dec)
	end

#-----------------------------------------------------------------------
#		dbfopen
#
# 概要
#		読込みモードでは、ヘッダを読み込んでフィールド配列にセットする
#		書込みモードでは、オープンするだけで何もしない
#
# 引数
#		filename：ファイル名
#		openmode：オープンモード "r"=読込み、c=新規作成
# 戻り値
#		なし
#-----------------------------------------------------------------------
	def dbfopen(filename, openmode)
		if openmode != "r" and openmode != "c" then
			p "オプションのオープンモード [" + openmode + "] が不正です"
			exit
		end

		@openmode = openmode
		# 読み込みモード
		if openmode == "r" then
			@fp = open(filename, "rb+")
			if @fp != nil then
				# （dbfヘッダを読み込んでも、いまのところ使うめどはないが）
				#1　ヘッダ先導部
				@hdlead.version = @fp.read(1)
				@hdlead.date1 = @fp.read(1)
				@hdlead.date2 = @fp.read(1)
				@hdlead.date3 = @fp.read(1)
				@hdlead.numrec = @fp.read(4)
				@hdlead.headerbytes = @fp.read(2)
				@hdlead.recordbytes = @fp.read(2)
				@hdlead.reserve = @fp.read(20)
				
				@numrecords = @hdlead.numrec.unpack("l").pop 		# - 1
				@headerlen = @hdlead.headerbytes.unpack("s").pop
				@recordlen = @hdlead.recordbytes.unpack("s").pop

				#2　フィールド記述部
				numfields = (@hdlead.headerbytes.unpack("s").pop - 1) / 32 - 1
				count = 0
				while count < numfields do
					hdldfieldname = @fp.read(11)	# フィールドの後ろに詰まっている\000をカットする
					hdldfieldtype = @fp.read(1)
					hdldreserve1 = @fp.read(4)
					hdldfieldsize = @fp.read(1)
					hdlddecimal = @fp.read(1)
					hdldreserve2 = @fp.read(14)
					
					@fields.add(hdldfieldname.scan(/^[^\000]+/).pop, hdldfieldtype, hdldfieldsize.unpack("C").pop, hdlddecimal.unpack("C").pop)
					
					count += 1
				end		#while count < numfields do
				@headerset = TRUE		# ヘッダ部を確認した
			else
				p "infile open fail"
			end

		# 新規作成モード
		else
			@fp = open(filename, "wb+")
		end
	end		#def dbfopen(filename, openmode)

#-----------------------------------------------------------------------
#		eof
#-----------------------------------------------------------------------
	def eof
		@dbfeof
	end

#-----------------------------------------------------------------------
#		close
#		新規作成モードの場合、ヘッダを書込む
#-----------------------------------------------------------------------
	def close
		if @openmode == "c" then
			putheader
			# ファイルの終端マーク（Chr(26)、&H1A、&O32）を書き込む
			@fp.seek(0 + @headerlen + @recordlen * @numrecords, File::SEEK_SET)
			@fp.write("\x1a")
		end
		
		if @fp != nil then
			@fp.close
		end
	end

#-----------------------------------------------------------------------
#		movefirst
#		ポインタを最初にセットして１レコード読込む
#
#	ファイルの読み書き位置は、レコード番号を元に指定する
#	ファイル終端にコード(&H1A ？)があるため、レコード数を知ってないとeofを捉えられない
#-----------------------------------------------------------------------
	def movefirst
		if @headerset == FALSE then
			return FALSE
		end
		
		@currentrecno = 0
		moverecord(@currentrecno)
		readrecord
	end

#-----------------------------------------------------------------------
#		movenext
#		レコードポインタ１進め、レコードを読込む
#-----------------------------------------------------------------------
	def movenext
		@currentrecno += 1
		moverecord(@currentrecno)
		if @currentrecno >= @numrecords then
			@currentrecno = @numrecords - 1
		else
			readrecord
		end
	end

#-----------------------------------------------------------------------
#		addnew
#		読み書きポインタを最後のレコードの後ろに動かす
#		空のファイルに対する最初のレコード追加の場合、ヘッダ部を書き込んでから読み書きポインタをセットする
#-----------------------------------------------------------------------
	def addnew
		if @headerset == FALSE then
			putheader
		end
		@currentrecno = @numrecords
		@fp.seek(0 + @headerlen + @recordlen * @currentrecno, File::SEEK_SET)

		count = 0
		while count < (@fields.numfields) do
			typechar = @fields.item(@fields.fieldname(count)).fieldtype
			if typechar == "N" or typechar == "F" then
				@fields.item(@fields.fieldname(count)).value = 0.0
			elsif typechar == "C" then
				@fields.item(@fields.fieldname(count)).value = ""
			else
				p "illegal type"
			end
			count += 1
		end
	end		# while count < (@fields.numfields) do

#-----------------------------------------------------------------------
#		update
#-----------------------------------------------------------------------
	def update
		writerecord
		
		if @currentrecno == @numrecords then		#   + 1
			@numrecords += 1
		end
	end

#-----------------------------------------------------------------------
#		numfields
#-----------------------------------------------------------------------
	def numfields
		@fields.numfields
	end

#-----------------------------------------------------------------------
#		fieldname
#-----------------------------------------------------------------------
	def fieldname(num)
		@fields.fieldname(num)
	end

#-----------------------------------------------------------------------
#		fieldspec
#		フィールド記述配列へのインターフェイス
#		紛らわしいが、次のfieldsでなく、こちらが@fieldsオブジェクトを返す
#		さしあたり、使わない
#-----------------------------------------------------------------------
	def fieldspec
		@fields
	end

#-----------------------------------------------------------------------
#		fields
#		フィールド要素へのインターフェイス
#		紛らわしいが、@fieldオブジェクトを返すのではなく、itemを返す
#-----------------------------------------------------------------------
	def fields(fname)
		@fields.item(fname)
	end

#-----------------------------------------------------------------------
#		putheader
#-----------------------------------------------------------------------
	def putheader
		@fp.seek(0, File::SEEK_SET)

		#1　ヘッダ先導部
		@fp.write("\003")																			# バージョンなど
		@fp.write([Time.now.strftime("%y").to_i].pack("c"))		# 最終更新日(年）
		@fp.write([Time.now.strftime("%m").to_i].pack("c"))		# 最終更新日(月）
		@fp.write([Time.now.strftime("%d").to_i].pack("c"))		# 最終更新日(日）
		@fp.write([@numrecords].pack("l"))										# レコード数
		@headerlen = ((@fields.numfields + 1) * 32 + 1)				# ヘッダのバイト数 ヘッダ先導部(32バイト)＋Σフィールド記述部(32バイト) ＋１  ヘッダの終わりに1バイト付く
		@fp.write([@headerlen].pack("s"))	

		count = 0
		@recordlen = 1
		while count < (@fields.numfields) do
			@recordlen += @fields.item(@fields.fieldname(count)).fieldsize	
			count += 1
		end
		@fp.write([@recordlen].pack("s"))					# レコードのバイト数 Σ((フィールド長)+1) レコードの先頭に削除フィールドが付く
		@fp.write("\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000")		# 予約領域など 20バイト出力

		#2　フィールド記述部
		count = 0
		while count < (@fields.numfields) do
			#フィールド名   （DBF ファイルの定義では11バイト)
			fieldnamelen = 0
			fieldnamearr = @fields.fieldname(count).split(//)
			while fieldnamelen < 11 do
				if fieldnamearr.size > 0 then
					@fp.write(fieldnamearr.shift)
				else
					@fp.write("\000")
				end
				fieldnamelen += 1
			end

			@fp.write(@fields.item(@fields.fieldname(count)).fieldtype)			# フィールド型   N,F:数値型、C:文字型
			@fp.write("\000\000\000\000")																		# 予約領域（4バイト）
			@fp.write([@fields.item(@fields.fieldname(count)).fieldsize.to_i].pack("C"))	# フィールド長
			@fp.write([@fields.item(@fields.fieldname(count)).decimal.to_i].pack("C"))		# 小数部の長さ
			@fp.write("\000\000\000\000\000\000\000\000\000\000\000\000\000\000")					# 予約領域など（14バイト）
			
			count += 1
		end		# while count < (@fields.numfields) do
		
		#2　ヘッダ部（フィールド記述部）の終わりマーク（&H0D）
		@fp.write("\x0d")
		@headerset = TRUE		# ヘッダ部を書き込んだ
	end

#-----------------------------------------------------------------------
#		writerecord
#-----------------------------------------------------------------------
	def writerecord
		# 1バイト空白を出力（dbfファイル仕様の削除マーク）
		@fp.write(" ")
		
		count = 0
		while count < (@fields.numfields) do
			typechar = @fields.item(@fields.fieldname(count)).fieldtype
			if typechar == "N" or typechar == "F" then
				# 例：@fp.printf("%8.3f", value)
				@fp.printf("%" + @fields.item(@fields.fieldname(count)).fieldsize.to_s + "." + @fields.item(@fields.fieldname(count)).decimal.to_s + "f",  @fields.item(@fields.fieldname(count)).value)
			elsif typechar == "C" then
				# 例：@fp.printf("%-8s", value)
				@fp.printf("%-" + @fields.item(@fields.fieldname(count)).fieldsize.to_s + "s",  @fields.item(@fields.fieldname(count)).value)
			else
				p "illegal type"
			end
			count += 1
		end		# while count < (@fields.numfields) do
	end

#-----------------------------------------------------------------------
#		readrecord
#-----------------------------------------------------------------------
	def readrecord
		# １バイト読み捨てる（dbfファイル仕様の削除マーク）
		@fp.read(1)
		
		count = 0
		while count < (@fields.numfields) do
			typechar = @fields.item(@fields.fieldname(count)).fieldtype
			if typechar == "N" or  typechar == "F" then
				@fields.item(@fields.fieldname(count)).value = @fp.read(@fields.item(@fields.fieldname(count)).fieldsize).to_f
			elsif typechar == "C" then
				@fields.item(@fields.fieldname(count)).value = @fp.read(@fields.item(@fields.fieldname(count)).fieldsize)
			else
				p "illegal type"
			end
			count += 1
		end		# while count < (@fields.numfields) do
	end

#-----------------------------------------------------------------------
#		moverecord
#		ポインタを引数のレコード番号にセットする
#
# 引数
#		recno：レコード番号
# 戻り値
#		なし
#-----------------------------------------------------------------------
	def moverecord(recno)
		if recno >= @numrecords then
			@dbfeof = TRUE
		elsif recno < 0 then
			@dbfbof = TRUE
		else
			@dbfeof = FALSE
			@dbfbof = FALSE
			# 読み書きの開始位置にセット　ヘッダ部の最後に1バイトのコード(&H0D)がある
			# バイト位置は０から始まる。レコード番号は０から始まる。
			@fp.seek(0 + @headerlen + @recordlen * recno, File::SEEK_SET)
		end
	end

#-----------------------------------------------------------------------
#		呼び出し制限
#-----------------------------------------------------------------------
	protected :putheader, :writerecord, :readrecord, :moverecord

end		# class DBFrecordset
