
OUTPUT_FORMAT(pei-i386)

MEMORY { rwx (rwxrwx) : ORIGIN = 0x400000, LENGTH = 0x10000}

ENTRY(main)

SECTIONS
{
	/* '.' is the location counter. It counts locations. */
	
	. = SIZEOF_HEADERS;
	. = ALIGN(__section_alignment__);

	/* Code */
    .ZERO  __image_base__ + ( __section_alignment__ < 0x1000 ? . : __section_alignment__ ) :
	{
		*(.ZERO)
		*(.data)
		*(.stab)
		*(.stabstr)
	} > rwx
}