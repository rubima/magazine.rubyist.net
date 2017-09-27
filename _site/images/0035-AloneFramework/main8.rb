DB_FILE = "data/todo.txt"
class AlController
  def initialize()
    @form = AlForm.new(
      AlInteger.new( "id", :foreign=>true ),
      AlDate.new( "create_date", :label=>"登録日", :value=>Time.now.strftime( '%Y/%m/%d' ) ),
      AlTextArea.new( "memo", :label=>"ToDoメモ", :required=>true ),
      AlDate.new( "limit_date", :label=>"期限" ),
      AlSubmit.new( "submit1", :value=>"決定",
        :tag_attr=> {:style=>"float: right;"} )
    )

    # use file
    @persist = AlPersistFile.connect( DB_FILE )
  end