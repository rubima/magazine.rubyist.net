  describe Array, '#delete' do
    subject { [1,2,3].delete(3) }
    it { should eq 3 }
  end

  describe Array, '#delete' do
    before do
      @array = [1,2,3]
      @array.delete(3)
    end
    subject { @array }
    its(:size) { should eq 2 }
  end
