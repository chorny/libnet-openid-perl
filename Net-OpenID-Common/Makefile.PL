use 5.006; #for cpantesters
use ExtUtils::MakeMaker;
WriteMakefile1( 'NAME' => 'Net::OpenID::Common',
               'VERSION_FROM' => 'lib/Net/OpenID/Common.pm',
               'PREREQ_PM'		=> {
                   'LWP::UserAgent' => 0,
                   'HTTP::Request'  => 0,
                   'HTTP::Status'  => 0,
                   'XML::Simple'    => 0,
                   'Time::Local'    => 0,
                   'Digest::SHA1'    => 0,
                   'MIME::Base64'    => 0,
                   'Math::BigInt'    => 0,
               },
               'BUILD_REQUIRES' => {
                   'Test::More'     => 0,
               },
               'LICENSE' => 'perl',
               'MIN_PERL_VERSION'  => 5.006, #warnings.pm, our
               ABSTRACT_FROM => 'lib/Net/OpenID/Common.pm',
               AUTHOR     => 'Martin Atkins <mart@degeneration.co.uk>',
               META_MERGE => {
                   resources => {
                       repository => 'http://github.com/apparentlymart/libnet-openid-perl/tree',
                   },
                   keywords => ['openid'],
               },
              );

sub WriteMakefile1 { #Written by Alexandr Ciornii
        my %params=@_;
        my $eumm_version=$ExtUtils::MakeMaker::VERSION;
        $eumm_version=eval $eumm_version;
        die "EXTRA_META is deprecated" if exists $params{EXTRA_META};
        die "License not specified" if not exists $params{LICENSE};
        if ($params{BUILD_REQUIRES}) { #and $eumm_version < 6.5503
            #Should be modified in future when EUMM will
            #correctly support BUILD_REQUIRES.
            #EUMM 6.5502 has problems with BUILD_REQUIRES
            $params{PREREQ_PM}={ %{$params{PREREQ_PM} || {}} , %{$params{BUILD_REQUIRES}} };
            delete $params{BUILD_REQUIRES};
        }
        delete $params{CONFIGURE_REQUIRES} if $eumm_version < 6.52;
        delete $params{MIN_PERL_VERSION} if $eumm_version < 6.48;
        delete $params{META_MERGE} if $eumm_version < 6.46;
        delete $params{META_ADD} if $eumm_version < 6.46;
        delete $params{LICENSE} if $eumm_version < 6.31;
        delete $params{AUTHOR} if $] < 5.005;
        delete $params{ABSTRACT_FROM} if $] < 5.005;
        WriteMakefile(%params);
}
