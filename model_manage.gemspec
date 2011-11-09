# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "model_manage"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["\u{306a}\u{306a}\u{3053}\u{308d}\u{3073}"]
  s.date = "2011-11-09"
  s.description = "\u{30e2}\u{30c7}\u{30eb}\u{3001}\u{30d5}\u{30a3}\u{30fc}\u{30eb}\u{30c9}\u{3068}\u{3044}\u{3063}\u{305f}\u{60c5}\u{5831}\u{3078}\u{7c21}\u{5358}\u{30a2}\u{30af}\u{30bb}\u{30b9}\u{3059}\u{308b}\u{3053}\u{3068}\u{3092}\u{76ee}\u{7684}\u{306b}\u{958b}\u{767a}\u{3057}\u{3066}\u{3044}\u{307e}\u{3059}\u{3002}"
  s.email = "7korobi@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/model_manage.rb",
    "lib/model_manage/active_record.rb",
    "lib/model_manage/base.rb",
    "lib/model_manage/mongoid.rb",
    "lib/model_manage/rails.rb",
    "model_manage.gemspec",
    "test/helper.rb",
    "test/test_model_manage.rb"
  ]
  s.homepage = "http://github.com/7korobi/model_manage"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "\u{30e2}\u{30c7}\u{30eb}\u{7ba1}\u{7406}\u{60c5}\u{5831}\u{4ed8}\u{4e0e}"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<simple_form>, [">= 0"])
      s.add_development_dependency(%q<mongoid>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<simple_form>, [">= 0"])
      s.add_dependency(%q<mongoid>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<simple_form>, [">= 0"])
    s.add_dependency(%q<mongoid>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

