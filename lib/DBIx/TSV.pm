package DBIx::TSV;

# DATE
# VERSION

use strict;
use warnings;
use DBIx::TextTableAny;

sub import {
    my $class = shift;

    %DBIx::TextTableAny::opts = (
        @_,
        backend => 'Text::Table::TSV',
    );
}

package
    DBI::db;

sub selectrow_tsv { goto &selectrow_texttable }
sub selectall_tsv { goto &selectall_texttable }

package
    DBI::st;

sub fetchrow_tsv { goto &fetchrow_texttable }
sub fetchall_tsv { goto &fetchall_texttable }

1;
# ABSTRACT: Generate TSV from SQL query result

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 use DBI;
 use DBIx::TSV;
 my $dbh = DBI->connect("dbi:mysql:database=mydb", "someuser", "somepass");

Selecting a row:

 print $dbh->selectrow_tsv("SELECT * FROM member");

Sample result (default backend is L<Text::Table::Tiny>):

 Name    Rank    Serial
 alice   pvt     123456

Selecting all rows:

 print $dbh->selectrow_tsv("SELECT * FROM member");

Sample result:

 Name    Rank    Serial
 alice   pvt     123456
 bob     cpl     98765321
 carol   brig gen        8745

Setting other options:

 DBIx::TSV->import(header_row => 0);

 my $sth = $dbh->prepare("SELECT * FROM member");
 $sth->execute;

 print $sth->fetchall_tsv;

Sample result:

 alice   pvt     123456
 bob     cpl     98765321
 carol   brig gen        8745


=head1 DESCRIPTION

This package is a thin glue between L<DBI> and L<DBIx::TextTableAny> (which in
turn is a thin glue to L<Text::Table::Any>). It adds the following methods to
database handle:

 selectrow_tsv
 selectall_tsv

as well as the following methods to statement handle:

 fetchrow_tsv
 fetchall_tsv

The methods send the result of query to Text::Table::Any (using the
L<Text::Table::TSV> backend) and return the rendered TSV data.

In essence, this is an easy, straightforward way produce TSV data from SQL
query.


=head1 SEE ALSO

L<DBIx::CSV>

L<DBIx::TextTableAny> which has a similar interface as this module and offers
multiple output formats.
