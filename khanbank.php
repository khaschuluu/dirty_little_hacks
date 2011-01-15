<?php
	$html = file_get_contents('http://www.khanbank.com/mn/294/%D0%A5%D0%B0%D0%BD%D1%88%D0%B8%D0%B9%D0%BD-%D0%BC%D1%8D%D0%B4%D1%8D%D1%8D.html');

	$match_res = preg_match_all('|<td[^>]*><img src=\"([^\"]*)\" border=0> <strong>([A-Z]{3})</strong></td><td align=center >([^<]*)</td><td align=right >([^<]*)</td><td align=right >([^<]*)</td><td align=right >([^<]*)</td><td align=right >([^<]*)</td><td align=right >([^<]*)</td></tr>|U', $html, $matches, PREG_SET_ORDER);

	echo "<table border=1>\n";
	foreach ($matches as $val) {
		echo "\t<tr>\n\t\t<td><img src=\"" . $val[1] . "\"/></td>\n\t\t<td>" . $val[2] . "</td>\n\t\t<td>" . $val[3] . "</td>\n\t\t<td>" . $val[4] . "</td>\n\t\t<td>" .$val[5] . "</td>\n\t\t<td>" . $val[6] . "</td>\n\t\t<td>" . $val[7] . "</td>\n\t\t<td>" . $val[8] . "</td>\n\t</tr>\n"; 
	}
	echo "</table>";
?>
