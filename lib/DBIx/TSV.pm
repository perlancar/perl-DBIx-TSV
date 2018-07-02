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

sub selectrow_tsv          { local %DBIx::TextTableAny::opts = (backend => 'Text::Table::TSV', header_row => 1); &selectrow_texttable(@_) }
sub selectall_tsv          { local %DBIx::TextTableAny::opts = (backend => 'Text::Table::TSV', header_row => 1); &selectall_texttable(@_) }
sub selectrow_tsv_noheader { local %DBIx::TextTableAny::opts = (backend => 'Text::Table::TSV', header_row => 0); &selectrow_texttable(@_) }
sub selectall_tsv_noheader { local %DBIx::TextTableAny::opts = (backend => 'Text::Table::TSV', header_row => 0); &selectall_texttable(@_) }

package
    DBI::st;

sub fetchrow_tsv          { local %DBIx::TextTableAny::opts = (backend => 'Text::Table::TSV', header_row => 1); &fetchrow_texttable(@_) }
sub fetchall_tsv          { local %DBIx::TextTableAny::opts = (backend => 'Text::Table::TSV', header_row => 1); &fetchall_texttable(@_) }
sub fetchrow_tsv_noheader { local %DBIx::TextTableAny::opts = (backend => 'Text::Table::TSV', header_row => 0); &fetchrow_texttable(@_) }
sub fetchall_tsv_noheader { local %DBIx::TextTableAny::opts = (backend => 'Text::Table::TSV', header_row => 0); &fetchall_texttable(@_) }

1;
# ABSTRACT: Generate TSV from SQL query result

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 use DBI;
 use DBIx::TSV;
 my $dbh = DBI->connect("dbi:mysql:database=mydb", "someuser", "somepass");

Generating a row of TSV (with header):

 print $dbh->selectrow_tsv("SELECT * FROM member");

Generating a row of TSV (without header):

Sample result:

 alice   pvt     123456

Generating all rows (with header):

 print $dbh->selectall_tsv("SELECT * FROM member");

Sample result:

 Name    Rank    Serial
 alice   pvt     123456
 bob     cpl     98765321
 carol   brig gen        8745

Generating all rows (without header):

 print $dbh->selectall_tsv_noheader("SELECT * FROM member");

Statement handle versions:

 print $sth->fetchrow_tsv;
 print $sth->fetchrow_tsv_noheader;
 print $sth->fetchall_tsv;
 print $sth->fetchall_tsv_noheader;


=head1 DESCRIPTION

This package is a thin glue between L<DBI> and L<DBIx::TextTableAny> (which in
turn is a thin glue to L<Text::Table::Any>). It adds the following methods to
database handle:

 selectrow_tsv
 selectall_tsv
 selectrow_tsv_noheader
 selectall_tsv_noheader

as well as the following methods to statement handle:

 fetchrow_tsv
 fetchall_tsv
 fetchrow_tsv_noheader
 fetchall_tsv_noheader

The methods send the result of query to Text::Table::Any (using the
L<Text::Table::TSV> backend) and return the rendered TSV data.

In essence, this is an easy, straightforward way produce TSV data from SQL
query.


=head1 SEE ALSO

L<DBIx::CSV>

L<DBIx::TextTableAny> which has a similar interface as this module and offers
multiple output formats.
