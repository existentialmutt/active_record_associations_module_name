require "active_record_associations_module_name/version"

# When working with ActiveRecord models within modules, retyping the module
# path within association definitions becomes repetitive. These extensions add a
# module_name option to AR-associations. You can specify a string that will
# be prepended to the definition's class_name option, or you can just say
# true to use the caller's module.
#
# Example:
#
# class Blog::Post
#   has_many :comments, module_name: true
#
#   # this replaces:
#   # has_many :comments, class_name: "Blog::Comment"
# end
#
module ActiveRecordAssociationsModuleName
  module AssociationClassMethodExtension
    def belongs_to(name, scope = nil, **options)
      options = process_module_name_option(name, options)
      super(name, scope, **options)
    end

    def has_one(name, scope = nil, **options)
      options = process_module_name_option(name, options)
      super(name, scope, **options)
    end

    def has_many(name, scope = nil, **options)
      options = process_module_name_option(name, options)
      super(name, scope, **options)
    end

    def has_and_belongs_to_many(name, scope = nil, **options)
      options = process_module_name_option(name, options)
      super(name, scope, **options)
    end

    private def process_module_name_option name, options
      if options[:class_name] && options[:module_name]
        raise ArgumentError, "Options `module_name` and `class_name` are incompatible. Please specify only one."
      elsif !options[:module_name]
        return options
      end

      module_name = options.delete(:module_name)
      class_name = name.to_s.singularize.camelize
      case module_name
      when true
        module_prefix = to_s.split("::")[0..-2].join("::")
      when String
        module_prefix = module_name
      else
        raise ArgumentError, "Option module_name must be either a String or `true`."
      end

      options[:class_name] = [module_prefix, class_name].reject(&:blank?).join("::")
      options
    end
  end
  ActiveRecord::Associations::ClassMethods.prepend(ActiveRecordAssociationsModuleName::AssociationClassMethodExtension)

  module ActiveRecordAssociationsModuleName::BuilderExtension
    def valid_options(options)
      super.push(:module_name)
    end
  end
  ActiveRecord::Associations::Builder::Association.singleton_class.prepend(ActiveRecordAssociationsModuleName::BuilderExtension)
end



