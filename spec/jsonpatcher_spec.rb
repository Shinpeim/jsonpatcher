require File.expand_path('spec_helper', File.dirname(__FILE__))

describe JSONPatcher do
  context "when simple array JSON is given" do
    let (:patcher) do
      JSONPatcher.new {
        array ->(element){ element.to_i }
      }
    end
    describe "#patch" do
      subject { patcher.patch('["1","2","3"]') }
      it "should be array of integers" do should == '[1,2,3]' end
    end
  end

  context "when simple object JSON is given" do
    let (:patcher) do
      JSONPatcher.new {
        object {
          property :age, ->(v){ v.to_i }
        }
      }
    end
    describe "#patch" do
      subject { patcher.patch('{"name":"shinpei","age":"28"}') }
      it {should == '{"name":"shinpei","age":28}'}
    end
  end

  context "when nested array JOSN is given" do
    let (:patcher) do
      JSONPatcher.new {
        array {
          object {
            property :age, ->(v){ v.to_i }
          }
        }
      }
    end
    describe "#patch" do
      subject {patcher.patch('[{"name":"shinpei","age":"28"},{"name":"kosuge","age":"22"}]')}
      it {should == '[{"name":"shinpei","age":28},{"name":"kosuge","age":22}]'}
    end
  end

  context "when nested object JSON is given" do
    let (:patcher) do
      JSONPatcher.new {
        object {
          property (:following) {
            array {
              object {
                property :age, ->(v){ v.to_i }
              }
            }
          }
        }
      }
    end
    describe "#patch" do
      subject {patcher.patch('{"following":[{"name":"shinpei","age":"28"},{"name":"kosuge","age":"22"}]}')}
      it {should == '{"following":[{"name":"shinpei","age":28},{"name":"kosuge","age":22}]}'}
    end
  end
end
