require "test_helper"
require "active_record_associations_module_name"

module Blog
  class Post < ActiveRecord::Base
    belongs_to :author, module_name: true
    has_one :metadata, module_name: true
    has_many :comments, module_name: true
    has_and_belongs_to_many :tags, module_name: true
  end
end

class Post < ActiveRecord::Base
  belongs_to :author, module_name: "Blog"
  has_one :metadata, module_name: "Blog"
  has_many :comments, module_name: "Blog"
  has_and_belongs_to_many :tags, module_name: "Blog"
end

class ActiveRecordAssociationsModuleNameTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert ActiveRecordAssociationsModuleName::VERSION
  end

  test "`module: true` points association to same module as caller" do
    assert_association_class_name(Blog::Post, :author, "Blog::Author")
    assert_association_class_name(Blog::Post, :metadata, "Blog::Metadatum")
    assert_association_class_name(Blog::Post, :comments, "Blog::Comment")
    assert_association_class_name(Blog::Post, :tags, "Blog::Tag")
  end

  test "`module: <String>` points association to specified module" do
    assert_association_class_name(Post, :author, "Blog::Author")
    assert_association_class_name(Post, :metadata, "Blog::Metadatum")
    assert_association_class_name(Post, :comments, "Blog::Comment")
    assert_association_class_name(Post, :tags, "Blog::Tag")
  end

  private def assert_association_class_name klass, assn_sym, class_name
    reflection = klass.reflections[assn_sym.to_s]
    reflection_class_name = reflection.options[:class_name]
    assert_equal class_name, reflection_class_name
  end
end
