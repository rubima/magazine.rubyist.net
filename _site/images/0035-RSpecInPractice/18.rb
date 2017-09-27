  shared_context '要素がふたつpushされている' do
    let(:latest_value) { 'value2' }
    before do
      @stack = Stack.new
      @stack.push 'value1'
      @stack.push latest_value
    end
  end

  describe Stack do
    describe '#size' do
      include_context '要素がふたつpushされている'
      subject { @stack.size }
      it { should eq 2 }
    end

    describe '#pop' do
      include_context '要素がふたつpushされている'
      subject { @stack.pop }
      it { should eq latest_value }
    end
  end
