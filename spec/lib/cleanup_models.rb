module DataMapper::Mongo::Spec
  module CleanupModels

    # Cleans up models after a spec by dropping the Mongo collection,
    # removing the model classes from the descendants list, and then
    # undefining the constants.
    #
    def cleanup_models(*models)
      unless models.empty?
        model = models.pop
        name = model.name

        DataMapper::Model.descendants.delete(model)

        if name && !name.length.zero? && Object.const_defined?(name)
          Object.send(:remove_const, name)
        end

        cleanup_models(*models)
      end
    end

  end # CleanupModels
end # DataMaper::Mongo::Spec
