class AlController
  def initialize()
    @form = AlForm.new(
      AlText.new( "text1", :label=>"名前", :value=>"ボズ・スキャッグス" ),
      AlRadios.new( "radio1", :label=>"性別",
        :options=>{ :r1=>"男性", :r2=>"女性", :r3=>"不明" }, :value=>"r3" ),
      AlCheckboxes.new( "check1", :label=>"趣味",
        :options=>{ :c1=>"音楽", :c2=>"スポーツ", :c3=>"読書" }, :required=>true ),
      AlSubmit.new( "submit1", :value=>"決定",
        :tag_attr=> {:style=>"float: right;"} )
    )
    @form.action = Alone::make_uri( :action => 'confirm' )
  end