module AbenteuerLeben
  # TODO: rename to StorageUtils
  module StorageUtils
    def self.md5_hash(file_path)
      Digest::MD5.file(file_path).hexdigest
    end

    def self.persist(file, domain = '')
      file_hash = AbenteuerLeben::StorageUtils.md5_hash file.tempfile.path
      file_ext  = File.extname file
      file_path = file_hash + file_ext

      new_path = "#{dir_path(domain)}/#{file_path}"

      FileUtils.copy_file file.path, new_path
      FileUtils.copy_file(file.path, new_path)

      file_path
    end

    def self.delete(file_path, domain = '')
      path = "#{dir_path(domain)}/#{file_path}"

      FileUtils.rm path
    end

    def dir_path(domain)
      dir_prefix = CONFIG['storage_path']
      dir_suffix = domain.blank? ? '' : "/#{domain}"
      "#{dir_prefix}#{dir_suffix}"
    end

    def self.generate_image_thumb(file); end
  end
end
