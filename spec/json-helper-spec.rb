require File.expand_path('spec_helper', File.dirname(__FILE__))

describe "simple array fixman" do
  let (:fixman) do
    JSON::Fixman.new {
      array {
        process {|element| element.to_i}
      }
    }
  end
  describe "#fix" do
    subject {fixman.fix('["1","2","3"]')} #fucking json... elements types should be number!
    it "should be array of integers" do should == '[1,2,3]' end
  end
end

describe "simple object fixman" do
  let (:fixman) do
    JSON::Fixman.new {
      object {
        key :age, process{|v|v.to_i}
      }
    }
  end
  describe "#fix" do
    subject {fixman.fix('{"name":"shinpei","age":"28"}')} #fuck! age should be number!
    it {should == '{"name":"shinpei","age":28}'}
  end
end

describe "nested array fixman" do
  let (:fixman) do
    JSON::Fixman.new {
      array {
        object {
          key :age, process{|v|v.to_i}
        }
      }
    }
  end
  describe "#fix" do
    subject {fixman.fix('[{"name":"shinpei","age":"28"},{"name":"kosuge","age":"22"}]')}
    it {should == '[{"name":"shinpei","age":28},{"name":"kosuge","age":22}]'}
  end
end

describe "nested object fixman" do
  let (:fixman) do
    JSON::Fixman.new {
      object {
        key "following", array {
          object {
            key :age, process {|v|v.to_i}
          }
        }
      }
    }
  end
  describe "#fix" do
    subject {fixman.fix('{"following":[{"name":"shinpei","age":"28"},{"name":"kosuge","age":"22"}]}')}
    it {should == '{"following":[{"name":"shinpei","age":28},{"name":"kosuge","age":22}]}'}
  end
end
