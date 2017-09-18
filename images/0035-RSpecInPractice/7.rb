  describe '#pop' do
    subject { @stack.pop }

    context 'スタックが空の場合' do
      it '返り値はnilであること' do
        should be_nil
      end
    end

    context 'スタックに値がある場合' do
      before do
        @stack.push 'value1'
        @stack.push 'value2'
      end

      it '最後の値を取得すること' do
        should eq 'value2'
      end
    end
  end
