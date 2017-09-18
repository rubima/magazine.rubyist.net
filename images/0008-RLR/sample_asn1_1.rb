require 'openssl'
require 'pp'
include OpenSSL

data = ASN1.decode(File.open(ARGV[0], 'rb'){|f| f.read()})

tbsCertificate, signatureAlgorithm, signatureValue = data.value
pp tbsCertificate
pp signatureAlgorithm
pp signatureValue

data = ASN1::Sequence [
  tbsCertificate,
  signatureAlgorithm,
  signatureValue,
]
File.open(ARGV[1], 'wb'){|f| f.write(data.to_der())}
