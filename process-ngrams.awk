#
# Simple AWK script to process lines of the corpus and print summed counts for each unique n-gram.
#
BEGIN { FS = "\t" }
{
    if ( $2 < 2000 ) {
        next
    }
    if ( $1 ~ /^[a-zA-Z']+$/ ) {
        if ( $1 == last ) {
            matchCount+=$3
            bookCount+=$4
        }
	else {
            if ( last != "" ) {
                print last"\t"matchCount"\t"bookCount
            }
            matchCount=$3
            bookCount=$4
        }
        last=$1
    }
}
END { print last"\t"matchCount"\t"bookCount }
