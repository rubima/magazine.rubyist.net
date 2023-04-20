require 'html-proofer'
task :test do
  options = {
    checks: [
      'Links',
      'Images',
      'Scripts',
    ],
    allow_missing_href: true,
    disable_external:   true,
    enforce_https:      true,
    ignore_empty_alt:   true,
    ignore_missing_alt: true,
  }

  HTMLProofer.check_directory('_site', options).run
end
