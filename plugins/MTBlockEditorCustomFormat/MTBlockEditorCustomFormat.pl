package MT::Plugin::MTBlockEditorCustomFormat;

use strict;
use warnings;
use utf8;

use version;
our $VERSION = 'v0.0.1';

use MT;
use JSON;
use base qw( MT::Plugin );

MT->add_plugin(__PACKAGE__->new({
        name        => 'MTBlockEditorCustomFormat',
        author_link => 'http://www.movabletype.org/',
        author_name => 'Six Apart Ltd.',
        version     => $VERSION,
        registry    => {
            tags => {
                modifier => {
                    mtbe_custom_json => sub {
                        my ($text, $attr) = @_;

                        return $text if !$attr;

                        $attr = [$attr] unless ref $attr;
                        my ($data, $opts) = apply_custom_filter($text, $attr);

                        my $json_text = JSON::to_json($data, $opts);
                        $json_text =~ s/([<>\/\+])/sprintf("\\u%04x",ord($1))/eg;

                        return $json_text;
                    },
                },
            },
            applications => {
                data_api => {
                    resources => {
                        cd => {
                            fields => [{
                                    name        => 'data_mtbe_custom',
                                    from_object => \&data_mtbe_custom_from_object,
                                },
                            ],
                        },
                        map({
                                $_ => {
                                    fields => [{
                                            name        => 'body_mtbe_custom',
                                            from_object => generate_from_object_handler('text'),
                                        },
                                        {
                                            name        => 'more_mtbe_custom',
                                            from_object => generate_from_object_handler('text_more'),
                                        },
                                    ],
                                    },
                        } qw(entry page)),
                    },
                },
            },
        },
    },
));

my %handler_map = (
    simple            => \&simple,
    simple_with_meta  => \&simple_with_meta,
    strip_meta_all    => \&strip_meta_all,
    strip_meta_setup  => \&strip_meta_setup,
    dedup_content     => \&dedup_content,
    stringify_content => \&stringify_content,
    raw               => sub { },
    pretty            => \&encode_opts_pretty,
    ascii             => \&encode_opts_ascii,
);

sub data_mtbe_custom_from_object {
    my ($obj)        = @_;
    my $content_type = $obj->content_type;
    my @field_ids    = map { $_->{id} } @{ $content_type->fields };
    my @data;
    for my $fid (@field_ids) {
        my $field   = $content_type->get_field($fid) || {};
        my $options = $field->{options}              || {};
        my $data    = $obj->data->{$fid};

        if ($field->{type} eq 'multi_line_text') {
            if ($obj->data->{"${fid}_convert_breaks"} eq 'block_editor') {
                my @params = MT->instance->multi_param('mtbe_custom');
                ($data) = apply_custom_filter($data, \@params);    # don't use $encode_opts here
            }
        }

        push @data,
            +{
            id    => $fid,
            data  => $data,
            label => $options->{label},
            type  => $field->{type},
            };
    }
    \@data;
}

sub generate_from_object_handler {
    my ($col) = @_;

    sub {
        my ($obj) = @_;

        my $cb   = $obj->convert_breaks;
        my $data = $obj->$col;
        if ($obj->convert_breaks eq 'block_editor') {
            my @params = MT->instance->multi_param('mtbe_custom');
            ($data) = apply_custom_filter($data, \@params);    # don't use $encode_opts here
        }

        return $data;
    };
}

sub apply_custom_filter {
    my ($text, $keys) = @_;

    require JSON;
    require MT::BlockEditor::Parser;

    my $parsed      = MT::BlockEditor::Parser->new(json => JSON->new)->parse({ content => $text });
    my %encode_opts = ();
    my @handlers;
    for my $key (@$keys) {
        if (my $h = $handler_map{$key}) {
            push @handlers, $h;
        } else {
            die "Unknown key: $key";
        }
    }
    transform($parsed, \@handlers, \%encode_opts);

    return ($parsed, \%encode_opts);
}

sub transform {
    my ($blocks, $handlers, $encode_opts) = @_;

    for my $b (@$blocks) {
        for my $h (@$handlers) {
            $h->($b, $encode_opts);
        }
        transform($b->{blocks}, $handlers, $encode_opts) if $b->{blocks};
    }
}

sub simple {
    strip_meta_all(@_);
    dedup_content(@_);
    stringify_content(@_);
}

sub simple_with_meta {
    strip_meta_setup(@_);
    dedup_content(@_);
    stringify_content(@_);
}

sub strip_meta_all {
    my ($block) = @_;
    delete $block->{meta};
}

sub encode_opts_ascii {
    my ($block, $encode_opts) = @_;
    $encode_opts->{ascii} = 1;
}

sub encode_opts_pretty {
    my ($block, $encode_opts) = @_;
    $encode_opts->{pretty} = 1;
}

sub strip_meta_setup {
    my ($block) = @_;

    if ($block->{meta} && %{ $block->{meta} }) {
        delete $block->{meta}{$_} for qw(label helpText);
        delete $block->{meta} unless %{ $block->{meta} };
    } else {
        delete $block->{meta};
    }
}

sub dedup_content {
    my ($block) = @_;

    if (@{ $block->{blocks} }) {
        delete $block->{content};
    } else {
        delete $block->{blocks};
    }
}

sub stringify_content {
    my ($block) = @_;

    $block->{content} = join('', @{ $block->{content} }) if ref $block->{content};
}

1;
