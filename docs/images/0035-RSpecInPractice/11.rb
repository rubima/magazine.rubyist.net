  RSpec::Matchers.define :be_latest_value do |expected|
    match do |actual|
      actual == latest_value
    end
  end

  describe Stack do
    before { @stack = Stack.new }
    describe '#pop' do
      subject { @stack.pop }

      context 'スタックが空の場合' do
        it { should be_nil }
      end

      # 具体的な値をcontextに書く
      context 'スタックの最後の値が"value2"の場合' do
        before do
          @stack.push 'value1'
          @stack.push 'value2'
        end

        it { should eq 'value2' }
      end

      # カスタムマッチャでメッセージを調整する
      context 'スタックに値がある場合' do
        let(:latest_value) { 'value2' }
        before do
          @stack.push 'value1'
          @stack.push latest_value
        end

        it { should be_latest_value }
      end
    end
  end
