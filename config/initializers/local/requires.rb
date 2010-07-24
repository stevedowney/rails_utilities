# core extensions
Dir["#{App.lib_dir}/core_extensions/**/*.rb"].each { |file| require_dependency file }
