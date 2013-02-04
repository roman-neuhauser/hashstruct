Gem::Specification.new do |s|
  s.name = "hashstruct"
  s.version = "0.0.1"
  s.license = "MIT"

  s.summary = "Hash/OpenStruct hybrid"
  s.description = s.summary

  s.homepage = "http://github.com/roman-neuhauser/hashstruct/"
  s.authors = ["Roman Neuhauser"]
  s.email = ["rneuhauser@suse.cz"]

  s.files = `git ls-files`.split("\n")
  s.require_path = 'lib'
end
