use v6;

unit module List::Combinations;

multi sub combos(@array, Int $of --> Array) is export {
	return [] if $of < 0;
	my int $size = @array.elems;
    return [(),] if $size < 1 || $of < 1;

	my @results;

	my Str $loops;
	for ^$of -> $level {
		$loops ~= qq/{"\t" x $level}loop (my int \$i$level = {$level == 0 ?? 0 !! '$i' ~ $level-1 ~ '+1'}; \$i$level < $size-{$of-$level-1}; \$i$level++) \{\n/;
	}
	$loops ~= qq/{"\t" x $of}\@results.push([{join('], ', ^$of .map: '@array[$i' ~ *)}]]);\n/;
	for ^$of -> $level {
		$loops ~= qq/{"\t" x $of-$level-1}\}\n/;
	}

	use MONKEY-SEE-NO-EVAL;
	EVAL $loops;

	@results;
}

multi sub combos(Int $n, Int $k --> Array) is export {
	combos(^$n, $k);
}
