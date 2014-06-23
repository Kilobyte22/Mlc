module Mlc
  class Builder
    @@libs = {}

    def self.build(what = 'mlp')
      lib = @@libs[what]
      raise "Unknown library #{what}" unless lib
      ret = []
      unless lib[:files]
        lib[:files] = lib[:cb].call(nil)
      end
      lib[:files].each do |el|
        dat = lib[:cb].call el
        if el =~ /\.rb$/
          dat = Mlc::Compiler.compile(dat)
        end
        ret << dat
      end
      ret.join "\n"
    end

    def self.register(name, &file_collector)
      @@libs[name.to_s] = {cb: file_collector}
    end
  end

  Builder.register :mlc do |file|
    if file
      File.read(file)
    else
      Dir.entries(Mlc.root 'lua').select {|el| not el[0] == '.'}.sort.map {|el| File.join(Mlc.root('lua'), el)}
    end
  end
end