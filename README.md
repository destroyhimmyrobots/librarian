librarian.k: Library loader for the K3 language.

Usage:
	$ nano ~/prgm/k/hellolibrarian.k

        \l librarian
        .librarian[`freadline]
        file:"file.txt"
        `0: freadline[`getLine] f
        freadline[`close] f
        \\

Remarks:

0. Put libraries under lib/.
1. Libraries are loaded into handles. They are therefore accesible only by lib[`ele] notation. Dot notation (lib.ele) is not valid.
2. Library locations mimic the k-tree. To load a nested library lib/a/b/...c/L.k, write
 
	`.librarian[``a.b...c.L,``local_dir_name]`
