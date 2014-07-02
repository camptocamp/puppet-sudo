require 'spec_helper'
describe 'sudo' do
  let (:facts) { {
    :sudoversion => '1.2.3',
  } }

  it { should compile.with_all_deps }
end
