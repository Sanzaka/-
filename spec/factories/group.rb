FactoryBot.define do
  factory :group do
    name {"テストグループ"}
    intro {"テストグループです"}
    group_type {"work_group"}
    direct_join {"true"}
  end
end