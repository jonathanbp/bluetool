/*
 * Parse command line arguments.
 */

#include <stdio.h>
#include <string.h>
#import "PBParams.h"
#import "PBBluetoothParams.h"

#define BUFLEN 1024

struct params
{
	char buffer[BUFLEN+1];
	int buflen;
	int cs;
};

%%{
	machine params;
	access fsm->;

	# A buffer to collect argurments

	# Append to the buffer.
	action append {
		if ( fsm->buflen < BUFLEN )
			fsm->buffer[fsm->buflen++] = fc;
	}

	# Terminate a buffer.
	action term {
		if ( fsm->buflen < BUFLEN )
			fsm->buffer[fsm->buflen++] = 0;
	}

	# Clear out the buffer
	action clear { fsm->buflen = 0; }

	action help { printf("help\n"); }
	action version { printf("version\n"); }
	action output { printf("output: \"%s\"\n", fsm->buffer); }
	action spec { printf("spec: \"%s\"\n", fsm->buffer); }
	action mach { printf("machine: \"%s\"\n", fsm->buffer); }

	# Helpers that collect strings
	string = [^\0]+ >clear $append %term;

	# Different arguments.
	help = ( '-h' | '-H' | '-?' | '--help' ) 0 @help;
	version = ( '-v' | '--version' ) 0 @version;
	output = '-o' 0? string 0 @output;
	spec = '-S' 0? string 0 @spec;
	mach = '-M' 0? string 0 @mach;

	main := ( 
		help | 
		version | 
		output |
		spec |
		mach
	)*;
}%%

%% write data;

@implementation PBBluetoothParams

+ (void) initParams:(struct params *)fsm 
{
	fsm->buflen = 0;
	%% write init;
}

+ (void) executeParams:(struct params *)fsm withString:(const char *)data andLength:(int) len 
{
	const char *p = data;
	const char *pe = data + len;

	%% write exec;
}

+ (int) finishParams:(struct params *)fsm
{
	//NSLog(@"returns %i - expects %i", fsm->cs, params_first_final);
	if ( fsm->cs == params_error )
		return -1;
	if ( fsm->cs >= params_first_final )
		return 1;
	return 0;
}

#define BUFSIZE 2048

+ (PBParams *) parseParams:(char**) argv withCount:(int)argc
{
	int a;
	struct params params;

	[PBBluetoothParams initParams:&params];
	for ( a = 1; a < argc; a++ )
		[PBBluetoothParams executeParams:&params withString:argv[a] andLength:((argv[a])+1)];
	if ([PBBluetoothParams finishParams:&params] != -1 )
		fprintf( stderr, "params: error processing arguments\n" );

	return 0;
}

@end
