function draw.SText(txt, font, x, y, color, px, py, sColor)
	draw.SimpleText(txt, font, x + 1, y + 1, sColor or Color(0,0,0,255), px, py)
	draw.SimpleText(txt, font, x, y, color, px, py)
end