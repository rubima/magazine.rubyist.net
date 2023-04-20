require 'html-proofer'
task :test do
  options = {
    checks: [
      'Links',
      'Images',
      'Scripts',
    ],
    ignore_empty_alt: true,
    ignore_missing_alt: true,
    check_external_hash: false,
    check_internal_hash: false,
  }

  HTMLProofer.check_directory('_site', options).run
end
