  describe Stack do
    before do
      @stack = Stack.new
    end

    describe '#push' do
      it '返り値はpushした値であること' do
        @stack.push('value').should eq 'value'
      end

      it 'nilをpushした場合は例外であること' do
        lambda { @stack.push(nil) }.should raise_error(ArgumentError)
      end
    end

    describe '#pop' do
      it 'スタックが空の場合、#popの返り値はnilであること' do
        @stack.pop.should be_nil
      end

      it 'スタックに値がある場合、#popで最後の値を取得すること' do
        @stack.push 'value1'
        @stack.push 'value2'
        @stack.pop.should eq 'value2'
        @stack.pop.should eq 'value1'
      end
    end

    describe '#size' do
      it '#sizeはスタックのサイズを返すこと' do
        @stack.size.should eq 0

        @stack.push 'value'
        @stack.size.should eq 1
      end
    end
  end