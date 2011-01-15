curl "http://www.khanbank.com/mn/294/%D0%A5%D0%B0%D0%BD%D1%88%D0%B8%D0%B9%D0%BD-%D0%BC%D1%8D%D0%B4%D1%8D%D1%8D.html" |\
	grep -E "<tr bgcolor=\"#[a-zA-Z0-9]{6}\">.*" |\
	sed -re "s|<tr[^\"]*\"|\n|g" |\
	grep -E "(daede1|FFFFFF)" |\
	sed -re "s|#(FFFFFF\|daede1)\"><td[^>]*><img src=\"([^\"]*)\" border=0> <strong>([A-Z]{3})</strong></td><td align=center >([^<]*)</td><td align=right >([^<]*)</td><td align=right >([^<]*)</td><td align=right >([^<]*)</td><td align=right >([^<]*)</td><td align=right >([^<]*)</td></tr>|\2 \3 \4 \5 \6 \7 \8 \9|g" \
		-e "s|([^<]*)</table>|\1|g"
