---
layout: post
title: 0013-CodeReview-dbfrecomb.rb
short_title: 0013-CodeReview-dbfrecomb.rb
created_on: 2006-02-20
tags: 0013 CodeReview
---
{% include base.html %}


[あなたの Ruby コードを添削します 【第 3 回】 dbf.rb]({{base}}{% post_url articles/0013/2006-02-20-0013-CodeReview %}) で解説した、添削前のサンプルコードです。

```ruby
#! ruby -Ks
=begin
			dbfrecomb ver. 0.2
					05-11-21

			入力dbfファイルから、２つのデフォルトフィールド(日時と雨量)の組を抜き出して指定したフィールドを加え、それらをレコードとするdbfファイルを出力する
			出力フィールドは、入力リストの先頭ファイルの同名フィールドの定義とする。
			文字型フィールドを出力指定すると、そのいずれか１つでも値のないレコードに対しては、レコードを出力しない
			入力は、コマンドラインで指定したリストファイルを順に読込む。
			出力は、コマンドラインで指定した出力ファイルに続けて書き込む。
			
=end

	require "dbf.rb"

	infile = ""
	outfile = ""
	refrain = 0.0

	if ARGV[0] == "-h" then
		p "dbfrecomb ver. 0.2"
		p "dbfrecomb [-opt] listfile outfile [reffield ...]"
		p "       opt:h         help"
		p "       reffield      reference field name"
		p ""
		p "(ex.) dbfrecomb listfile.txt outdata.dbf pntid name area"
		p ""
		p "listfile format:"
		p "dbffile1.dbf"
		p "dbffile2.dbf"
		p "  ..."

		exit
	end

	reffield = []
	reffieldnum = 0
	if ARGV.size >= 2 then
		listfile = ARGV[0]
		outfile = ARGV[1]
		count = 0
		while count < ARGV.size - 2
			reffield[count] = ARGV[count + 2]
			count += 1
		end
		

		reffieldnum = count		# 出力フィールド数(指定フィールドのみ)
	else
		p "引数が不正です"
		p "dbfrecomb [-opt] listfile outfile [reffield ...]"
		p "       opt:h         help"
		p "       reffield      reference field name"
		p ""
		p "(ex.) dbfrecomb listfile.txt outdata.dbf pntid name area"
		
		exit
	end

	# 入力リストの取得
	filelist = []
	count = 0
	fplist = open(listfile, "r")
	while not fplist.eof
		filelist[count] = fplist.gets.chomp
		count += 1
	end
	infilenum = count
	fplist.close

	datefield = "datetime"
	rainfallfield = "rainfall"

	dbfout = DBFrecordset.new
	dbfout.dbfopen(outfile, "c")

	# 出力フィールドの生成（既定フィールドのみ）
	dbfout.addfield(datefield, "C", 20, 0)
	dbfout.addfield(rainfallfield, "N", 10, 4)

	listcount = 0
	while listcount < infilenum
		dbfin = DBFrecordset.new		# ファイルごとにオブジェクトを生成する
		dbfin.dbfopen(filelist[listcount], "r")
		
p "input file:" + filelist[listcount]

		numfields = dbfin.numfields
		datetime = []
		outfield = []

		# 最初のファイルだけの処理
		# 出力フィールドの生成（コマンドラインで指定したフィールドを追加）
		if listcount == 0 then
			fieldcount = 0
			while fieldcount < numfields
				fieldname = dbfin.fieldname(fieldcount)
				count = 0
				while count < reffieldnum
					if fieldname.downcase == (reffield[count]).downcase then
						reffield[count] = fieldname		# 大文字小文字の違いにかかわらず受け付ける
						dbfout.addfield(fieldname, dbfin.fields(fieldname).fieldtype, \
													dbfin.fields(fieldname).fieldsize, dbfin.fields(fieldname).decimal)
					end
					count += 1
				end		# while count < reffieldnum
				fieldcount += 1
			end		# while fieldcount < numfields
		end		# if listcount == 0 then

		# 入力ファイルのフィールドごとの処理
		filecomplete = 0
		outfieldcount = 0
		fieldcount = 0
		while fieldcount < numfields
			fieldname = dbfin.fieldname(fieldcount)
			
			# 雨量フィールドであれば、日時の形式に変換して配列に取得
			# 雨量フィールドの判別は、"T"ではじまり、１０バイトで、最後が"0"であることとする。
			if fieldname[0, 1] == "T" and fieldname.size == 10 and fieldname[-1, 1] == "0" then		# T039250030
				outfield[outfieldcount] = fieldname
				datetime[outfieldcount] = "20" + fieldname[1, 2] + "/" \
																	+ sprintf("%02d", fieldname[3, 1].hex) + "/" \
																	+ fieldname[4, 2] + " " \
																	+ fieldname[6, 2] + ":" + fieldname[8, 2] + ":00"
				outfieldcount += 1
			end

			# コマンドラインで指定したフィールドが入力ファイルにあるかをチェック
			count = 0
			while count < reffieldnum
				if fieldname  == (reffield[count])  then
					filecomplete += 1
				end
				count += 1
			end		# while count < reffieldnum
			fieldcount += 1
		end		#  while fieldcount < numfield

		# すべてのフィールドを見てコマンドラインで指定したフィールドがなければ、抜ける
		if filecomplete != reffieldnum then
			p "指定したフィールドが " + filelist[listcount] + " のテーブルにありません"
			
			exit
		end

		# 出力ファイルの生成
		dbfin.movefirst
		while not dbfin.eof
			# 入力したレコードを出力するかをチェック
			# すべての文字型の指定フィールドに空白以外の値があるかで判定する
			count = 0
			validcount = 0
			refccount = 0
			while count < reffieldnum
				if dbfin.fields(reffield[count]).fieldtype == "C" then
					refccount += 1
					if dbfin.fields(reffield[count]).value.gsub(" ", "") != "" then
						validcount += 1
					end
				end
				count += 1
			end		# while count < reffieldnum

			# 文字型の指定フィールドのすべてに空白以外の値のある場合にレコードを出力する
			if validcount == refccount then
				count = 0
				while count < outfieldcount
					dbfout.addnew

					dbfout.fields(datefield).value = datetime[count]
					dbfout.fields(rainfallfield).value = dbfin.fields(outfield[count]).value
					refcount = 0
					while refcount < reffieldnum
						dbfout.fields(reffield[refcount]).value = dbfin.fields(reffield[refcount]).value
						refcount += 1
					end		# while refcount < reffieldnum

					dbfout.update
					count += 1
				end		# while count < outfieldcount
			end		# if count == reffieldnum then
			dbfin.movenext
		end		# while not dbfin.eof
		
		dbfin.close
		listcount += 1
	end		#  listcount < infilenum
	
	dbfout.close

```


