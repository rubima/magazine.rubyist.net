  describe Stack, '#pop' do
    let(:stack) { Stack.new }
    subject { stack.pop }

    context 'スタックが空の場合' do
      it { should be_nil }
    end

    context 'スタックに値がある場合' do
      let(:oldest_value) { 'value1' }
      let(:latest_value) { 'value2' }

      before do
        stack.push oldest_value
        stack.push latest_value
      end

      it { should eq latest_value }
    end
  end
