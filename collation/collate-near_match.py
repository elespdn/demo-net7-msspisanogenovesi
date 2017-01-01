from collatex import *
collation = Collation()
witness_16998 = open( "paragrafo-1-16998.txt", encoding='utf-8' ).read()
witness_354 = open( "paragrafo-1-354.txt", encoding='utf-8' ).read()
outfile = open("output-near_match.txt", 'w', encoding='utf-8')

collation.add_plain_witness( "BnF 16998", witness_16998 )
collation.add_plain_witness( "BnF 354", witness_354 )
alignment_table = collate(collation, near_match=True, layout='vertical')
print(alignment_table, file=outfile)
outfile.close()
